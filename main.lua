-- name    grow stone辅助
-- author  Etrom
-- date    2018/1/23
-- info    for mi5 :1920*1080

require "TSLib"
local ts = require("ts")

--做一些初始化
init("0", 0);			--指定坐标系，横屏home右
luaExitIfCall(true);

--全局变量
glRunningFlag=true;
glLastRubyTime=0;
rubyIntval=110;

faces={"boy","girl","cike","fox","blue","rabbit"}


--zone1:动作定义

--反作弊测试(TODO)
function handleAnti()
	-- body
	if (isColor(  59,  418, 0x83603b, 85) and 
		isColor(  72,  435, 0x36261a, 85) and 
		isColor( 104,  420, 0x270f03, 85))  then
		print("出现了。。。")
		--截图
		mSleep(800);
		--capScreen();
		--mSleep(1000);
		--关闭程序
		closeApp("net.supercat.stone");
		mSleep(2500)
		--打开程序
		runApp("net.supercat.stone");
		
		
		--循环判断是否启动好 TODO
		mSleep(37000)
		
		--后续的事情由handleBadUI()来搞

		--重置时间
		glLastRubyTime=0;
	end

end

--截图
function capScreen()
	-- body
	current_time = os.time(); --以时间戳命名进行截图
	w,h = getScreenSize();
	-- 右下角顶点坐标最大为 (宽度最大值-1, 高度最大值-1)
	snapshot(current_time..".png", 0, 0, w-1, h-1); 
end

--抓宝石
function getRuby()
	--判断时间到没有
	nowtime=os.time();
	if nowtime - glLastRubyTime > rubyIntval+10 then
		sys_log("开始点宝石");
		mSleep(600); --可能点到分解
		tap(74,1065);
		mSleep(700);
		tap(287,1185);
		mSleep(700);
		tap(237,957);
		mSleep(500);
		glLastRubyTime=nowtime;
	end
end


--做一次merge（找点版）
function makeMergePoint()
	keepScreen(true)
	map={{}, {}, {}, {}} 
	for i=1,4 do
		for j=1,8 do
			map[i][j]=getLvl(i,j)
			sys_log(i..","..j..":"..map[i][j])
		end
		
	end
	keepScreen(false)
	--保存是否处理过的
	done={0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
	--开始合并(TODO:天气控制)
	for i=1,31 do
		for j=i+1,32 do
			--如果两个格子的level一样，并且没有被处理过，则进行合并。
			if map[math.floor((i-1)/8)+1][(i-1)%8+1]==map[math.floor((j-1)/8)+1][(j-1)%8+1] 
			and map[math.floor((i-1)/8)+1][(i-1)%8+1]~=0 and done[i]==0 and done[j]==0 then
				done[i]=1
				done[j]=1
				x1 = ((i-1) % 8) * 112 + 95
				x2 = ((j-1) % 8) * 112 + 95
				y1 = math.floor((i-1) / 8) * 112 + 1412;
				y2 = math.floor((j-1) / 8) * 112 + 1412;

				moveTo(x1,y1,x2,y2,35);
			end
			
		end
	end
end

--找这个位置的lv(x,y)in(1,1)~(4,8)
function getLvl(x,y)
	-- body
	x1=(y-1)*112.5+46
	y1=(x-1)*112.5+1369
	x2=x1+95
	y2=y1+85
	
	--5 unique
	x0,y0= findColorInRegionFuzzy(0xdd9500, 100, x1, y1, x2, y2); 
	if x0>-1 then return 15;end
	
	x0,y0= findColorInRegionFuzzy(0xfef99d, 100, x1, y1, x2, y2); 
	if x0>-1 then return 17;end
	x0,y0= findColorInRegionFuzzy(0xa4c6d3, 100, x1, y1, x2, y2); 
	if x0>-1 then return 18;end
	x0,y0= findColorInRegionFuzzy(0x2be2ff, 100, x1, y1, x2, y2); 
	if x0>-1 then return 19;end
	x0,y0= findColorInRegionFuzzy(0x203a8c, 100, x1, y1, x2, y2); 
	if x0>-1 then return 20;end
	x0,y0= findColorInRegionFuzzy(0x64111d, 100, x1, y1, x2, y2); 
	if x0>-1 then return 21;end
	x0,y0= findColorInRegionFuzzy(0xea6b33, 100, x1, y1, x2, y2); 
	if x0>-1 then return 22;end
	x0,y0= findColorInRegionFuzzy(0x9abac6, 100, x1, y1, x2, y2); 
	if x0>-1 then return 23;end
	x0,y0= findColorInRegionFuzzy(0x245f58, 100, x1, y1, x2, y2); 
	if x0>-1 then return 24;end
	
	x0,y0= findColorInRegionFuzzy(0x122e22, 100, x1, y1, x2, y2); 
	if x0>-1 then return 8;end
	x0,y0= findColorInRegionFuzzy(0x6abe30, 100, x1, y1, x2, y2); 
	if x0>-1 then return 9;end
	x0,y0= findColorInRegionFuzzy(0x0fb0fd, 100, x1, y1, x2, y2); 
	if x0>-1 then return 10;end
	x0,y0= findColorInRegionFuzzy(0xd90000, 100, x1, y1, x2, y2); 
	if x0>-1 then return 11;end
	x0,y0= findColorInRegionFuzzy(0xa85c3c, 100, x1, y1, x2, y2); 
	if x0>-1 then return 12;end
	x0,y0= findColorInRegionFuzzy(0x5a5a5a, 100, x1, y1, x2, y2); 
	if x0>-1 then return 13;end
	x0,y0= findColorInRegionFuzzy(0xc66518, 100, x1, y1, x2, y2); 
	if x0>-1 then return 14;end
	
	
	return 0;
end

--处理界面异常
function handleBadUI()
	-- body
	--1,右上角叉叉
	multiColTap({{901,351,0x6c4020},{920,358,0xd0d0d0},{929,380,0x50280c}})
	--2,右下角加号
	mSleep(200)
	multiColTap({{973,1821,0x3d2e23},{991,1837,0xffffff},{1005,1854,0x260f04}})
	--3，处理灰色按钮
end

--目标face（抓图版）
function getFace()
	for key,value in pairs(faces) do
		print(key, value)
		x, y = findImageInRegionFuzzy("guy_"..value..".png", 80, 467, 1069, 589, 1192, 0);
		if x~=-1 and y~=-1 then
			return key
		end
	end
	return -1
end

--测试不同石头的特征颜色
function testAll(color)
	for i=0,2 do
		for j=0,6 do
			x0=j*125+113
			y0=i*172+1211
			x1=x0+95
			y1=y0+95
			xx,yy= findColorInRegionFuzzy(color, 100, x0, y0, x1, y1); 
			sys_log((i*7+j+8)..":"..xx)
		end
	end
	
end

--zone2:状态判断
--------------------------------------------------------------------------------------------
--zone3:系统杂项

--日志
function sys_log(msg)
	nLog("["..os.date().."]  "..msg)
	print("["..os.date().."]  "..msg)
	--toast("["..os.date().."]  "..msg,1)
end

--zone4:主对话框

--显示主对话框
function show_dialog()
	local sz = require("sz")
	local json = sz.json
	MyTable = {
		["style"] = "default",
		["width"] = 680,
		["height"] = 880,
		["orient"] = 1,
		["config"] = "save_growstone_helper.dat",
		["timer"] = 99,
		["title"] = "Grow Stone辅助 - by Etrom",
		views = {
			{
				["type"] = "RadioGroup",
				["list"] = "4排自动合成,测试用,",
				["select"] = "1",
			},
		}
	}
	local MyJsonString = json.encode(MyTable);
	return showUI(MyJsonString);
end

--真正开始做动作了
function dowork(type,extra)
	sys_log("开始挂机，挂机模式:"..type);
	glRunningFlag=true;

	if type=="0" then
		math.randomseed(os.time())
		while glRunningFlag do
			sys_log("while")
			getRuby();
			handleAnti();
			handleBadUI();
			makeMergePoint();
			mSleep(5000);
		end
	end

	if type=="1" then
		testAll(0x245f58)
	end
	sys_log("挂机终止!")

end

--zone5:main
function main()
	--测试区
--	while true do
--		doMerge();
--		mSleep(5000);
--	end

	--capScreen();
	--makeAMerge("lv14.png");
	--测试区
	sys_log("=================")
	--getAFace();

	--
	--弹出主程序面板
	ret, worktype, extra= show_dialog();
	mSleep(2000)
	if ret==1 then
		--根据不同的动作，执行
		--设定上次清理时间为当前时间
		glLastRubyTime=os.time();
		dowork(worktype,extra);
	end

end

main();

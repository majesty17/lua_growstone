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
		mSleep(37000)
		--关闭xx
		os.execute("input keyevent 4")
		--tap(914,355);
		
		
		--点加号
		mSleep(2000)
		tap(993,1823);
		mSleep(1000)

		--重置时间
		--glLastRubyTime=0;
		--继续
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
		tap(74,1206);
		mSleep(400);
		tap(287,1278);
		mSleep(400);
		tap(8,356);
		mSleep(200);
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
	--开始合并
	--保存是否处理过的
	done={0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
	--开始合并
	for i=1,31 do
		for j=i+1,32 do
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
	if x0>-1 then return 23;end
	
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



--目标face（抓图版）
function getFace()
	array = {"Lua", "Tutorial"}
	for key,value in pairs(faces) do
		print(key, value)
		x, y = findImageInRegionFuzzy("guy_"..value..".png", 80, 467, 1069, 589, 1192, 0);
		if x~=-1 and y~=-1 then
			return key
		end
	end
	return -1
end
--目标face (分析点版)
function getAFace()
	
	good=0
	sum=0
    keepScreen(true)

	for x=455,641,3 do
		for y=1045,1245,3 do
			cor = getColor(x, y); 
			if cor~=0x403024 then
				good=good+1
				sum=sum+cor
			end
			
			
		end
		
	end
	keepScreen(false)

	if sum==20705041656 or sum==9543954167 or sum==9479655760 or 
		sum ==9176557265 or sum==8999620849 or sum== 9577416402 or
		sum==8724910727 or sum==20719460996 or sum==8838790209 then
		sys_log((sum).." it is boy")
	elseif sum==9232212575 or sum==9374098665 or sum==9350024043 or sum==9261678718 or
		sum==8921764002 or sum==8685123308 or sum==9306178084 or sum==9331554048 or 
		sum==9398802640 then
		sys_log((sum).." it is girl")
		
	elseif sum==8457483222 or sum==8622148581 or sum==7619538596 or sum==8903992657 or
		sum==7901983244 or sum==8268905466 or sum==8830403066 or sum==8181222562 then
		sys_log((sum).." it is cike_boy")
	elseif sum==5292358690 or sum==5282139339 or sum==5669592430 or sum==5086229205 
		or sum==5414907061 or sum==5074727354 or sum==5244652514 then
		sys_log((sum).." it is cike_girl")
	elseif sum==10478294089 or sum==10538026874 or sum==11020328862 or sum==10842800473 or
		sum==9879409779 or sum==10605099012 or sum==10297708794 then
		sys_log((sum).." it is fox")
	elseif sum==9264716635 or sum==9947053816 or sum==9476133693 or sum==8287978895 or sum==20702301819 or
		sum==8436471063 or sum==9422591889 or sum==8953871852 or sum==10048558273 then
		sys_log((sum).." it is blue")
	elseif sum==10866869967 or sum==10632429174  or sum==11024825297 or sum==10693058206 or 
		sum==10344331287 or sum==10792284583 or sum==10363435974 then
		sys_log((sum).." it is rabbit")
	else
		sys_log((sum).." not found")
	end
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
	--print("["..os.date().."]  "..msg)
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
				["list"] = "4排自动合成,自动刷地牢(不可用),",
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
			--makeARealMerge();
			makeMergePoint();
			mSleep(5000);
		end
	end

	if type=="?" then
		--
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
	--sys_log("=================")
	--getAFace();

	
	
	--testAll(0x245f58)
	--弹出主程序面板
	ret, worktype, extra= show_dialog();
	--handleAnti();
	if ret==1 then
		--根据不同的动作，执行
		--设定上次清理时间为当前时间
		glLastRubyTime=os.time();
		dowork(worktype,extra);
	end

end

main();

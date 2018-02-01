-- name    grow stone辅助
-- author  Etrom
-- date    2018/1/23
-- info    for mi5 :1920*1080

require "TSLib"

--做一些初始化
init("0", 0);			--指定坐标系，横屏home右
luaExitIfCall(true);

--全局变量
glRunningFlag=true;
glLastRubyTime=0;
rubyIntval=110;

lvpic={"lv07"}
faces={"boy","girl","cike","fox","blue","rabbit"}



--zone1:动作定义

--反作弊测试(TODO)
function handleAnti()
	-- body
	if (isColor(  76,  449, 0x947850, 85) and 
		isColor(  47,  456, 0xdcc094, 85) and 
		isColor(  44,  485, 0x947850, 85) and 
		isColor(  80,  485, 0x36261a, 85)) then
		print("出现了。。。")
		--截图
		mSleep(800);
		capScreen();
		mSleep(1000);
		--关闭程序
		closeApp("net.supercat.stone");
		mSleep(3000)
		--打开程序
		runApp("net.supercat.stone");
		mSleep(45000)
		--关闭xx，调自动模式，点加号
		click(914,355);
		mSleep(2000)
		click(938,713);
		mSleep(2000)
		click(871,1686);
		mSleep(2000)
		click(986,1831);
		mSleep(2000)
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
--抓宝石(todo)
function getRuby()
	--判断时间到没有
	nowtime=os.time();
	if nowtime - glLastRubyTime > rubyIntval+10 then
		sys_log("开始点宝石");
		mSleep(600); --可能点到分解
		click(74,1206);
		mSleep(400);
		click(287,1278);
		mSleep(400);
		click(8,356);
		mSleep(200);
		glLastRubyTime=nowtime;
	end
end

--对各个lv的石头做合并
function doMerge()
	for i=7,21 do
		name=string.format("lv%02d.png",i)
		makeAMerge(name)
		nLog(name)
	end
end
--做一次合并
function makeAMerge(picname)
	x, y = findImageInRegionFuzzy(picname, 80, 11, 546, 420, 746, 0);
	if x ~= -1 and y ~= -1 then  --找第一个图成功
		x1, y1=findImageInRegionFuzzy(picname, 80, x+40, 546, 420, 746, 0);
		if x1 ~= -1 and y1 ~= -1 then
			touchDown(x,y)
			mSleep(100)
			touchMove(x1, y1)
			mSleep(100)
			touchUp(x1, y1)
		else
			x1, y1=findImageInRegionFuzzy(picname, 80, 11, y+40, 420, 746, 0);
			if x1 ~= -1 and y1 ~= -1 then
				touchDown(x,y)
				mSleep(100)
				touchMove(x1, y1)
				mSleep(100)
				touchUp(x1, y1)
			end
		end
		
	end
end

--做一次随机merge
function makeARealMerge()
	-- body
	from = math.random(0,31)
	to = math.random(0,31)
	if from==to then
		return
	end
	x1 = (from % 8) * 112 + 95
	x2 = (to % 8) * 112 + 95
	y1 = math.floor(from / 8) * 112 + 1412;
	y2 = math.floor(to / 8) * 112 + 1412;
	mySwipe(x1,y1,x2,y2);
end

--平滑swip
function mySwipe(x1,y1,x2,y2)
	-- x move
	touchDown(x1, y1)
	if x2~=x1 then
		step_x=28;--x2>x1?112:-112;
		if x2<x1 then
			step_x=-28;
		end
		
		for i=x1,x2,step_x do
			touchMove(i, y1);
		end
	end
	-- y move
	if y2~=y1 then
		step_y=28;--y2>y1?116:-116;
		if y2<y1 then
			step_y=-28;
		end
		
		for i=y1,y2,step_y do
			touchMove(x2, i);
		end
	end
	touchUp(x2, y2);
end

--点击
function click(x, y)
    touchDown(x, y);
    mSleep(30);
    touchMove(x, y); -- 安卓部分机型单点不生效的情况下可以加上此句
    touchUp(x, y);
	mSleep(300);
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
	sumr=0
	sumg=0
	sumb=0
    keepScreen(true)

	for x=455,641,3 do
		for y=1045,1245,3 do
			r,g,b = getColorRGB(x, y); 
			if r~=64 and g~=48 and b~=36 then
				good=good+1
				sumr=sumr+r
				sumg=sumg+g
				sumb=sumb+b
			end
			
			
		end
		
	end
	keepScreen(false)
	sys_log("avg is "..(sumr/good)..","..(sumg/good)..","..(sumb/good))

end

--zone2:状态判断

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
				["list"] = "4排自动合成(不可用),自动随机合石头模式,自动刷地牢模式(不可用),",
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
		while glRunningFlag do
			handleAnti();
			doMerge();
			mSleep(5000);
		end
	end
	if type=="1" then
		math.randomseed(os.time())
		while glRunningFlag do
			getRuby();
			handleAnti();
			makeARealMerge();
			mSleep(100);
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

	--getAFace();
	
	--弹出主程序面板
	ret, worktype, extra= show_dialog();
	--sys_log("对话框输出: "..ret..worktype..extra);
	if ret==1 then
		--根据不同的动作，执行
		--设定上次清理时间为当前时间
		glLastRubyTime=os.time();
		dowork(worktype,extra);
	end

end

main();

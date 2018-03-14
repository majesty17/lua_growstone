-- name    grow stone辅助
-- author  Etrom
-- date    2018/1/23
-- info    for mi5 :1920*1080

require "TSLib"
local ts = require("ts")

--做一些初始化
init("0", 0);			--指定坐标系，横屏home右
luaExitIfCall(true);

nLog("test")
print("test")
toast("test",1)
log("test")
for i=0,2 do
	for j=0,6 do
		x0=j*125+113
		y0=i*172+1211
		x1=x0+95
		y1=y0+95
		xx,yy= findColorInRegionFuzzy(0x245f58, 100, x0, y0, x1, y1); 
		nLog((i*7+j+8)..":"..xx)
	end
end
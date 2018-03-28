w,h = getScreenSize();--此段代码仅供演示用，不可复制粘贴直接运行
MyJsonString = [[
{
  "style": "default",
  "width": ]]..(w-100)..[[,
  "height": ]]..(h-200)..[[,
  "config": "save_111.dat",
  "timer": 99,
  "views": [
    {
      "type": "Label",
      "text": "设置",
      "size": 25,
      "align": "center",
      "color": "0,0,255"
    },
    {
      "type": "RadioGroup",
      "list": "选项 1,选项 2,选项 3,选项 4,选项 5,选项 6,选项 7",
      "select": "1"
    },
    {
      "type": "CheckBoxGroup",
      "list": "选项 1,选项 2,选项 3,选项 4,选项 5,选项 6,选项 7",
      "select": "3@5"
    }
  ]
}
]]

ret, input1, input2, input3 = showUI(MyJsonString);
nLog(ret)
nLog(input1)
nLog(input2)
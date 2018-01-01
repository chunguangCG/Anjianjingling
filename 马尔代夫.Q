[General]
SyntaxVersion=2
BeginHotkey=49
BeginHotkeyMod=2
PauseHotkey=0
PauseHotkeyMod=0
StopHotkey=50
StopHotkeyMod=2
RunOnce=1
EnableWindow=
MacroID=4457d8bc-0072-44e7-9511-bd0fc0847f21
Description=马尔代夫
Enable=1
AutoRun=0
[Repeat]
Type=0
Number=1
[SetupUI]
Type=2
QUI=
[Relative]
SetupOCXFile=
[Comment]

[Script]
//首先关闭所有chrome网页
//Plugin.WebOperation.GetFocus 参数1
//i = Plugin.LazyOffice.WordOpen("D:\lazy\ok\ok.doc",1)
//Plugin.LazyOffice.WordSaveAs("D:\lazy\ok\ok.txt")
//Plugin.LazyOffice.WordClose(i)
/*
Plugin.WebOperation.GoURL ("cms.sekorm.com/snps/")
Delay 2000
MoveTo -907, 268
LeftClick 1
SayString "zneWR56ylKQ1Pvtn"
MoveTo -718, 343
LeftClick 1
*/

//Call Plugin.Web.Bind("WQM.exe")
//Call Plugin.Web.Go("cms.sekorm.com/snps/")
//Call Plugin.Web.HtmlInput("按键精灵","id:kw") 
//Call Plugin.Web.HtmlClick("id:su")

//找到chrome启动位置
path = "C:\Users\Administrator\AppData\Local\Google\Chrome\Application\chrome.exe"
// 启动浏览器
If Plugin.chrome.launch(path, "--user-data-dir=c:\user_data") = False Then 
    TracePrint "启动失败"
    ExitScript
End If

// 获取启动浏览器后的默认标签
id = Plugin.chrome.get_ids()
If id = "" Then 
         TracePrint "获取标签id失败"
        ExitScript
End If

// 跳转到世强文章录入系统
Call Plugin.chrome.load(id, "https://cms.sekorm.com/snps/")
// 等待载入完成
Do
Delay 2000
TracePrint "..."
Loop While Plugin.chrome.is_loading(id)

// 输入验证码
Call Plugin.chrome.exec_js(id, "document.querySelector('#code').value='zneWR56ylKQ1Pvtn';")
//需要聚焦在code上，目前不好使
//Plugin.WebOperation.GetFocus("id:code")
MoveTo -796, 236
LeftClick 1
KeyPress "Space", 1
MoveTo -717, 316
LeftClick 1
// 点击搜索按钮,目前不好使
Call Plugin.chrome.exec_js(id, "document.querySelector('#ant-btn login-form-button ant-btn-primary ant-btn-lg').click();")
Delay 5000
mytitle = Plugin.File.ReadFileEx("D:\lazy\ok\title.txt")
//Call Plugin.Sys.SetCLB(all)
Call Plugin.chrome.exec_js(id, "document.querySelector('#title').value='" & mytitle & "';")
Delay 3000
mycontent = Plugin.File.ReadFileEx("D:\lazy\ok\content.txt")
Call Plugin.chrome.exec_js(id, "document.querySelector('#ueImgUrl').value='" & mycontent & "';")


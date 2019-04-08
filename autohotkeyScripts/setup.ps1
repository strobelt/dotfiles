$shell = New-Object -ComObject ("WScript.Shell")

Get-ChildItem "." -Filter *.ahk | 
Foreach-Object {
    $file = Get-Item $_
    $shortCut = $shell.CreateShortcut($env:APPDATA + "\Microsoft\Windows\Start Menu\Programs\Startup\" + $file.BaseName + ".lnk")
    $shortCut.TargetPath = $file.FullName
    $shortCut.Save()
    Invoke-Item $file.FullName
}

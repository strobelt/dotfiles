# Self-elevate the script if required
if (-Not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] 'Administrator')) {
 if ([int](Get-CimInstance -Class Win32_OperatingSystem | Select-Object -ExpandProperty BuildNumber) -ge 6000) {
  $CommandLine = "-File `"" + $MyInvocation.MyCommand.Path + "`" " + $MyInvocation.UnboundArguments
  Start-Process -FilePath PowerShell.exe -Verb Runas -ArgumentList $CommandLine
  Exit
 }
}

# Allow Remote Signed Packages
Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned -Force

# Update Help Files
Update-Help -Force

# Install Chocolatey
Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))


# Install Programs
cinst git.install --params "/NoAutoCrlf /NoShellIntegration /GitOnlyOnPath" -y
cinst vscode --params "/NoDesktopIcon /NoContextMenuFiles /NoContextMenuFolders" -y
cinst autohotkey.install --params="'/DefaultVer:U64'" -y
cinst 7zip vim firacode ubuntu.font sourcetree nvm microsoft-windows-terminal -y

#  meslolg.dz not working


# Reload Environment Variables
$env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")

# NuGet provider is required to continue when installing or importing PowerShellGet. Maybe a  flag -y?
# Configure Terminal
Install-Module -Name PowerShellGet -Force
Import-Module PowerShellGet
Install-Module PSReadLine -Scope CurrentUser -Force -SkipPublisherCheck
Install-Module z -Force -SkipPublisherCheck -AllowClobber
Install-Module posh-git -Scope CurrentUser -Force -SkipPublisherCheck
Install-Module oh-my-posh -Scope CurrentUser -Force -SkipPublisherCheck
Install-Module DockerCompletion -Scope CurrentUser -Force -SkipPublisherCheck


# Setup Git
git config --global user.email lhsperez@gmail.com
git config --global user.name "Luiz Strobelt"
git config --system core.longpaths true


# Configures Windows to accept longer file paths
New-Item -Path "HKLM:SYSTEM\CurrentControlSet\Control\FileSystem" -Name "LongPathsEnabled" -Value 1 -Force


# Refresh Environment
refreshenv
$env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")


# Setup Node - For some reason nvm is notbeing found until restarting powershell
nvm install latest
nvm use (nvm list)


# Allow Remote Signed Packages
Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned -Force


# Setup AutoHotkey
$ScriptPath = Split-Path $MyInvocation.MyCommand.Path
powershell.exe -noprofile -executionpolicy bypass -file "$ScriptPath\autohotkeyScripts\setup.ps1"


# Setup PowerShell config
New-Item -Name "git" -ItemType "directory" -Path "c:\"
Set-Location "c:\git"
git clone https://github.com/strobelt/poshfiles.git poshfiles
Set-Location "~/Documents/WindowsPowerShell"
New-Item -Path "Microsoft.PowerShell_profile.ps1" -ItemType HardLink -Value "c:\git\poshfiles\Microsoft.PowerShell_profile.ps1"


# Setup Vim Plug
$plug_uri = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
$plug_path = $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath(
  "C:\tools\vim\vim*\autoload\plug.vim"
)
Invoke-WebRequest -Uri $plug_uri -OutFile "$plug_path"

# Setup .vimrc
Set-Location "c:\git"
git clone https://github.com/strobelt/myvimrc.git myvimrc
Set-Location "~/"
New-Item -Path ".vimrc" -ItemType HardLink -Value "c:\git\myvimrc\.vimrc"
mkdir ~/temp


# Install VS 2022 Community
$vs_uri = 'https://aka.ms/vs/17/release/vs_community.exe'
Set-Location "~/Downloads"
Invoke-WebRequest -Uri $vs_uri -OutFile vs_community.exe
Start-Process -Wait -FilePath .\vs_community.exe -ArgumentList "--quiet --add Microsoft.VisualStudio.Workload.CoreEditor --add Microsoft.VisualStudio.Workload.ManagedGame --add Microsoft.VisualStudio.Workload.NetWeb"

# Install IntelliJ IDEA
choco install intellijidea-community -y


# Install WSL2
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
Invoke-WebRequest -Uri "https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi" -Outfile "C:\temp\wsl_update_x64.msi"
Start-Process -Wait -FilePath msiexec -ArgumentList "/i C:\temp\wsl_update_x64.msi /quiet"

wsl --set-default-version 2


exit

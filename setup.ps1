# TODO: Install ConEmu config files and VS and VSCode extensions

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
cinst vivaldi 7zip conemu vim docker-for-windows microsoft-teams firacode dbeaver googlechrome notepadplusplus.install postman sourcetree nvm yarn -y


# Reload Environment Variables
$env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")


# Configure ConEmu
Install-Module -Name PowerShellGet -Force
Import-Module PowerShellGet
Install-Module PSReadLine -Scope CurrentUser -Force -SkipPublisherCheck
Install-Module z -Force -SkipPublisherCheck
Install-Module posh-git -Scope CurrentUser -Force -SkipPublisherCheck
Install-Module oh-my-posh -Scope CurrentUser -Force -SkipPublisherCheck
Install-Module DockerCompletion -Scope CurrentUser -Force -SkipPublisherCheck


# Setup Git
git config --global user.email lhsperez@gmail.com
git config --global user.name "Luiz Strobelt"
git config --system core.longpaths true


# Configures Windows to accept longer file paths
New-Item -Path "HKLM:SYSTEM\CurrentControlSet\Control\FileSystem" -Name "LongPathsEnabled" -Value 1 -Force


# Setup Node
nvm install latest
nvm use (nvm list)


# Setup AutHotkey
$ScriptPath = Split-Path$MyInvocation.MyCommand.Path
& "$ScriptPath\autohotkeyScripts\setup.ps1"


# Setup PowerShell config
New-Item -Name "git" -ItemType "directory" -Path "c:\"
Set-Location "c:\git"
git clone https://github.com/strobelt/poshfiles.git poshfiles
Set-Location (Get-Item $PROFILE).DirectoryName 
New-Item -Path "Microsoft.PowerShell_profile.ps1" -ItemType HardLink -Value "c:\git\poshfiles\Microsoft.PowerShell_profile.ps1"

# Setup Vim Plug
$uri = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
(New-Object Net.WebClient).DownloadFile(
  $uri,
  $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath(
    "C:\Program Files (x86)\vim\vim80\autoload\plug.vim"
  )
)

# Setup .vimrc
Set-Location "c:\git"
git clone https://github.com/strobelt/myvimrc.git myvimrc
Set-Location "~/"
New-Item -Path ".vimrc" -ItemType HardLink -Value "c:\git\myvimrc\.vimrc"


# Install VS
cinst visualstudio2019professional --package-parameters "--locale en-US" -y
cinst visualstudio2019-workload-manageddesktop visualstudio2019-workload-netcoretools visualstudio2019-workload-netweb visualstudio2019-workload-visualstudioextension visualstudio2019-workload-data -y


exit

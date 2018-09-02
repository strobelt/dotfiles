# Allow Remote Signed Packages
Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned -Force


# Install Chocolatey
Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))


# Install Programs
cinst git.install --params "/NoAutoCrlf /NoShellIntegration /GitOnlyOnPath" -y
cinst vscode --params "/NoDesktopIcon /NoContextMenuFiles /NoContextMenuFolders" -y
cinst 7zip.install googlechrome autohotkey.portable notepadplusplus.install conemu vim postman docker steam -y
cinst visualstudio2017professional --package-parameters "--locale en-US" -y
cinst visualstudio2017-workload-manageddesktop visualstudio2017-workload-netcoretools visualstudio2017-workload-netweb visualstudio2017-workload-visualstudioextension -y


# Configure ConEmu
Install-Module -Name PowerShellGet -Force
Import-Module PowerShellGet
Install-Module -Name PSReadLine -AllowPrerelease -Force -SkipPublisherCheck
Install-Module posh-git -Scope CurrentUser -Force -SkipPublisherCheck
Install-Module oh-my-posh -Scope CurrentUser -Force -SkipPublisherCheck
Install-Module DockerCompletion -Scope CurrentUser -Force -SkipPublisherCheck
Install-Module PSReadLine -Scope CurrentUser -Force -SkipPublisherCheck


# Setup Git
git config --global user.email lhsperez@gmail.com
git config --global user.name "Luiz Strobelt"


# Setup PowerShell config
New-Item -Name "git" -ItemType "directory" -Path "c:\"
Set-Location "c:\git"
git clone git@github.com:strobelt/poshfiles.git poshfiles
Set-Location poshfiles
Copy-Item Microsoft.PowerShell_profile.ps1 (Get-Item $PROFILE).DirectoryName -force
exit
@echo off
rem (c) 2024 Heavy Sniper Mk2. All rights reserved.
rem Unauthorized Copying of this script is prohibited without my permission.
rem https://youtube.com/@heavysnipermk2781

title Automated windows CMD installer

rem user choice selection

:start
cls
echo   +----------------------------------------+
echo   ^|  Windows 7 Build 6730 CMD installer    ^|
echo   ^|   Automated Windows CMD installer      ^|
echo   ^|         By Heavy Sniper Mk2            ^|
echo   +----------------------------------------+
echo.
echo Please Choose an option.
echo.
echo 1. Install Windows 7 Build 6730
echo 2. Check WIM image information
echo 3. Reboot system
echo 4. Exit to cmd

set /p choice=Enter your choice (1,2,3,4): 

if "%choice%"=="1" (
    goto option1
) else if "%choice%"=="2" (
    goto option2
) else if "%choice%"=="3" (
    goto option3 
) else if "%choice%"=="4" (
    goto option4
) else if "%choice%"=="5" (
    goto option5
) else (
    echo Invalid choice. Please enter 1, 2, 3 or 4.
    pause
    goto :start
)

rem partitioning disk

:option1
cls
echo lis dis | diskpart | find "Disk"
set /p disk_number=Enter the disk number you want to use:
cls
set /p confirm=You selected disk %disk_number% are you sure this is the Disk you want to wipe? (Y/N): 
if /i "%confirm%" neq "Y" (
    echo Operation cancelled.
    echo Press any Key to start again.
	pause >nul
    goto start
)
set /p confirm=FINAL WARNING: DISK WIPING WILL OCCUR! ARE YOU SURE THAT %disk_number% IS THE ONE YOU WANT? (Y/N): 
if /i "%confirm%" neq "Y" (
    echo Operation cancelled.
    echo Press any Key to start again.
	pause >nul
    goto start
)
cls
cls
echo Preparing Disk...
date 06-12-2008 >NUL
date 06-12-2008
set temp_script=%temp%\diskpart_script.txt
(
echo sel dis %disk_number%
echo clean
echo cre par pri
echo form fs=ntfs quick
echo ass letter=C
echo active
echo exit
) > %temp_script%
diskpart /s %temp_script% >NUL

rem Check if Diskpart encountered any errors
if %errorlevel% neq 0 (
    echo Error: Diskpart encountered an error. Please check your disk selection and try again.
    echo Press any key to go back to start page...
    pause >nul
    goto start
)

rem Deploying WIM

date 06-12-2008
cls
echo Preparing Disk [DONE]
echo Deploying WIM image...
cd \
cd /d %~dp0
echo.
wimlib-imagex.exe apply install.wim 1 C:

rem this script uses dism before but i decided to switch to windows 7 PE so dism is not working now...

::dism /Apply-Image /ImageFile:%~dp0install.wim /Index:1 /ApplyDir:C:\
::if %errorlevel% neq 0 (
::    echo Error: WIM deployment failed. Please check the WIM image and try again.
::    echo Press any key to go back to start page...
::    pause >nul
::    goto start
::)

cls
echo Preparing Disk [DONE]
echo Deploying WIM image [DONE]
echo Creating Boot Files...
bcdboot.exe C:\Windows /s C:\
date 06-12-2008
cls
echo Preparing Disk [DONE]
echo Deploying WIM mage [DONE]
echo Creating Boot Files [DONE]
echo.
echo your system will reboot in a few seconds...
wpeutil reboot

rem Check WIM image information
:option2
cls
cd \
cd /d %~dp0
dism /Get-WimInfo /WimFile:install.wim /index:1
echo.
echo Press any key to go back to start page...
pause >nul
goto start

rem reboot system
:option3
echo rebooting system... Please wait...
wpeutil reboot

rem Exit to cmd
:option4
exit /b

rem dev mode (verbose) 
:option5
cls
echo lis dis | diskpart | find "Disk"
set /p disk_number=Enter the disk number you want to use:
cls
set /p confirm=You selected disk %disk_number% are you sure this is the Disk you want to wipe? (Y/N): 
if /i "%confirm%" neq "Y" (
    echo Operation cancelled.
    echo Press any Key to start again.
	pause >nul
    goto start
)
date 06-12-2008 >NUL
date 06-12-2008 
set temp_script=%temp%\diskpart_script.txt
echo sel dis %disk_number% > %temp_script%
echo clean >> %temp_script%
echo cre par pri >> %temp_script%
echo form fs=ntfs quick >> %temp_script%
echo ass letter=C >> %temp_script%
echo active >> %temp_script%
echo exit >> %temp_script%
diskpart /s %temp_script%
echo.
echo DISKPART DONE! Press any key to continue to deployment
pause >nul
cd \
cd /d %~dp0
wimlib-imagex.exe apply install.wim 1 C:
::dism /Apply-Image /ImageFile:install.wim /Index:1 /ApplyDir:C:\
echo.
echo DEPLOYMENT DONE! Press any key to continue.
pause >nul
bcdboot.exe C:\Windows /s C:\
echo.
echo DONE! Press any key to Reboot.
wpeutil reboot
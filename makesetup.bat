@echo off
cls
title Cli Setup v1.00
path=%path%;%~dp0bin
echo Cli Setup v1.00
echo.
echo Welcome!
echo This script can make a Cli Installer exe.
echo Note: In the upcoming questions, you absolutely can't leave anything blank, or it will cause generation to fail.
echo.
echo Press any key to make a new installer.
pause >nul
cls
echo 1.Basic infos
echo.
echo Note: the folder name must set "Setup".
set /p fp=Folder path:
set /p out=Output file path:
set /p main=Main execute file name:
cls
echo 2.Version Info
echo.
set /p cn=CompanyName:
set /p fd=FileDescription:
set /p fv=FileVersion:
set /p lc=LegalCopyright:
set /p pn=ProductName:
set /p pv=ProductVersion:
cls
echo 3.Other infos
echo.
set /p license=License txt file:
set /p aw=App website:
cls
echo 4.Start packaging
echo.
echo Preparing files
md "%~dp0temp\Setup"
xcopy /e /h /i /r /y "%fp%" "%~dp0temp\Setup"
copy "%license%" "%~dp0temp\Setup"
copy "%~dp0bin\pecmd.exe" "%~dp0temp\Setup"
echo @echo off > "%~dp0temp\Install.bat"
echo cls >> "%~dp0temp\Install.bat"
echo title %pn% Setup >> "%~dp0temp\Install.bat"
echo echo %pn% Setup >> "%~dp0temp\Install.bat"
echo tar -xf "%%0" -C "%%temp%%" "LICENSE.txt" >> "%~dp0temp\Install.bat"
echo echo. >> "%~dp0temp\Install.bat"
echo echo Please review this software license agreement. >> "%~dp0temp\Install.bat"
echo echo. >> "%~dp0temp\Install.bat"
echo type "%%temp%%\LICENSE.txt" >> "%~dp0temp\Install.bat"
echo echo. >> "%~dp0temp\Install.bat"
echo echo Press any key to agree >> "%~dp0temp\Install.bat"
echo pause ^>nul >> "%~dp0temp\Install.bat"
echo cls >> "%~dp0temp\Install.bat"
echo echo Select Installation folder >> "%~dp0temp\Install.bat"
echo echo. >> "%~dp0temp\Install.bat"
echo set /p dir=Folder path: >> "%~dp0temp\Install.bat"
echo cls >> "%~dp0temp\Install.bat"
echo echo Start Installation >> "%~dp0temp\Install.bat"
echo echo. >> "%~dp0temp\Install.bat"
echo echo Extracting files >> "%~dp0temp\Install.bat"
echo md "%%dir%%" >> "%~dp0temp\Install.bat"
echo tar -xf "%%0" -C "%%dir%%" >> "%~dp0temp\Install.bat"
echo "%%dir%%\pecmd.exe" LINK %%userprofile%%\Desktop\%pn%,%%dir%%\%main% >> "%~dp0temp\Install.bat"
echo "%%dir%%\pecmd.exe" LINK %%ProgramData%%\Microsoft\Windows\Start Menu\Programs\%pn%,%%dir%%\%main% >> "%~dp0temp\Install.bat"
echo del "%%dir%%\PECMD.EXE" >> "%~dp0temp\Install.bat"
echo del "%%dir%%\LICENSE.txt" >> "%~dp0temp\Install.bat"
echo echo. >> "%~dp0temp\Install.bat"
echo echo Configuration registry >> "%~dp0temp\Install.bat"
echo reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\%pn%" /f >> "%~dp0temp\Install.bat"
echo reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\%pn%" /v DisplayName /t REG_SZ /d "%pn%" /f >> "%~dp0temp\Install.bat"
echo reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\%pn%" /v UninstallString /t REG_SZ /d "%%dir%%\unis000.bat" /f >> "%~dp0temp\Install.bat"
echo reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\%pn%" /v InstallLocation /t REG_SZ /d "%%dir%%" /f >> "%~dp0temp\Install.bat"
echo reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\%pn%" /v Publisher /t REG_SZ /d "%cn%" /f >> "%~dp0temp\Install.bat"
echo reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\%pn%" /v DisplayIcon /t REG_SZ /d "%%dir%%\%main%" /f >> "%~dp0temp\Install.bat"
echo reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\%pn%" /v DisplayVersion /t REG_SZ /d "%pv%" /f >> "%~dp0temp\Install.bat"
echo reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\%pn%" /v URLInfoAbout /t REG_SZ /d "%aw%" /f >> "%~dp0temp\Install.bat"
echo reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\%pn%" /v URLUpdateInfo /t REG_SZ /d "%aw%" /f >> "%~dp0temp\Install.bat"
echo echo. >> "%~dp0temp\Install.bat"
echo echo Installation finshed. >> "%~dp0temp\Install.bat"
echo echo Press any key to exit >> "%~dp0temp\Install.bat"
echo pause ^>nul >> "%~dp0temp\Install.bat"
echo exit /b >> "%~dp0temp\Install.bat"
echo @echo off > "%~dp0temp\Setup\unis000.bat"
echo cls >> "%~dp0temp\Setup\unis000.bat"
echo title %pn% Uninstall >> "%~dp0temp\Setup\unis000.bat"
echo echo %pn% Uninstall >> "%~dp0temp\Setup\unis000.bat"
echo echo. >> "%~dp0temp\Setup\unis000.bat"
echo echo Press any key to uninstall %pn% >> "%~dp0temp\Setup\unis000.bat"
echo pause ^>nul >> "%~dp0temp\Setup\unis000.bat"
echo cls >> "%~dp0temp\Setup\unis000.bat"
echo echo Start Uninstall >> "%~dp0temp\Setup\unis000.bat"
echo echo. >> "%~dp0temp\Setup\unis000.bat"
echo echo Delete files >> "%~dp0temp\Setup\unis000.bat"
echo del "%%userprofile%%\Desktop\%pn%.lnk" >> "%~dp0temp\Setup\unis000.bat"
echo del "%%ProgramData%%\Microsoft\Windows\Start Menu\Programs\%pn%.lnk" >> "%~dp0temp\Setup\unis000.bat"
echo move /y "%%~dp0unis001.bat" "%%temp%%" >> "%~dp0temp\Setup\unis000.bat"
echo start cmd.exe /c "%%temp%%\unis001.bat" >> "%~dp0temp\Setup\unis000.bat"
echo exit /b >> "%~dp0temp\Setup\unis000.bat"
echo @echo off > "%~dp0temp\Setup\unis001.bat"
echo timeout /t 2 /nobreak ^>nul >> "%~dp0temp\Setup\unis001.bat"
echo for /f "tokens=2,*" %%%%a in ^('reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\%pn%" /v "InstallLocation" ^^^| findstr "REG_SZ"'^) do set inst=%%%%b >> "%~dp0temp\Setup\unis001.bat"
echo set "newinst=%%inst:~0,-1%%" >> "%~dp0temp\Setup\unis001.bat"
echo reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\%pn%" /va /f >> "%~dp0temp\Setup\unis001.bat"
echo rd /s /q "%%newinst%%" >> "%~dp0temp\Setup\unis001.bat"
echo exit /b >> "%~dp0temp\Setup\unis001.bat"
echo.
echo Making installer
Bat_To_Exe_Converter_4.2 /bat "%~dp0temp\Install.bat" /exe "%~dp0temp\archive.exe" /x64 /uac-admin /Company "%cn%" /Description "%fd%" /FileVersion "%fv%" /Copyright "%lc%" /ProductName "%pn%" /ProductVersion "%pv%"
pushd "%~dp0temp\Setup"
tar -caf "%~dp0temp\setup.zip" *
popd
copy /b "%~dp0temp\archive.exe" + "%~dp0temp\setup.zip" "%out%"
rd /s /q "%~dp0temp"
echo.
echo Finshed
echo Press any key to exit
pause >nul
exit /b

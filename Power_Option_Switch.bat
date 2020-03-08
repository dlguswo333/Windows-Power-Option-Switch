@echo off
title Power Option Select
mode con lines=14
setlocal enabledelayedexpansion
set output=
set output_list[0]=
set /a index=1
for /f "tokens=* delims=1" %%i in ('powercfg /list') do (set line=%%i && if not "!line:GUID=!"=="!line!" (set output_list[!index!]=%%i && set /a index += 1))
set /a index=1
for /f "tokens=2 delims==" %%s in ('set output_list[') do (echo !index!: %%s && set /a index += 1)
echo * ^=^> Active
set /p select=Select Power Option: 
if not defined output_list[%select%] (echo Wrong Input && pause && exit)
set selected_output=!output_list[%select%]!
for /f "tokens=2 delims=:(" %%i in ("%selected_output%") do (set selected_GUID=%%i)
powercfg /setactive%selected_GUID%

echo.
echo | set /p=Active Power Option: 
powercfg  /getactivescheme
echo.
pause
exit

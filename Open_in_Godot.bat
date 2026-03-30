@echo off
set "GODOT_PATH=C:\Users\RAMMLS\AppData\Local\Microsoft\WinGet\Packages\GodotEngine.GodotEngine_Microsoft.Winget.Source_8wekyb3d8bbwe\Godot_v4.6.1-stable_win64.exe"
start "" "%GODOT_PATH%" --path "%~dp0" -e

@echo off
chcp 65001
setlocal enabledelayedexpansion
:first

set BLENDER_USER_CONFIG=%~dp0%\VRMConvert
set BLENDER_USER_SCRIPTS=%~dp0%\VRMConvert
for /f "usebackq delims=" %%A in (`powershell -command "(Get-ItemProperty HKLM:\Software\\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object DisplayName,DisplayVersion,InstallLocation | Where-Object {$_.DisplayName -eq \"Blender\"} | Sort -Property DisplayVersion | Select-Object -Last 1 ).DisplayVersion"`) do set version=%%A
for /f "usebackq delims=" %%A in (`powershell -command "(Get-ItemProperty HKLM:\Software\\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object DisplayName,DisplayVersion,InstallLocation | Where-Object {$_.DisplayName -eq \"Blender\"} | Sort -Property DisplayVersion | Select-Object -Last 1 ).InstallLocation"`) do set blender=%%A
set blender=%blender:"=%

for /f "usebackq delims=" %%A in (`curl --version`) do set curlresult=%%A
for /f "usebackq delims=" %%A in (`ver`) do set windowsversion=%%A

echo.
echo ===Enviroment Checker===
echo BlenderVersion: %version%
echo BlenderInstallLocation: %blender%
echo CurlResult: %curlresult%
echo WindowsVersion: %windowsversion%


if "%blender%" == "" (
echo "Blenderが検出できませんでした。インストーラをダウンロードし、インストールします"
curl -L -o "%~dp0Blender.msi" https://mirrors.aliyun.com/blender/release/Blender3.2/blender-3.2.2-windows-x64.msi
Blender.msi
goto first
)
set blender='%blender%'

for /f "usebackq delims=" %%A in (`powershell -command "Join-Path %blender% blender.exe"`) do set blender=%%A
set blender="%blender%"
:cycle

set VRM=%1
set OUTPUT="%~1-glbtoglb.glb"

echo.
echo ===Convert Files Checker===
echo BLENDER = %BLENDER%
echo VRM = %VRM%
echo OUTPUT = %OUTPUT%
echo.
echo.

IF NOT DEFINED BLENDER goto error
IF NOT DEFINED VRM goto error-drop

echo ===Convert Start===
%BLENDER% "%~dp0empty.blend"^
 --python "%~dp0glbconv.py"^
 --background^
 -- --input %VRM%^
 --output %OUTPUT%
echo ===Convert End===
echo.
echo.

:error-drop
echo "モデルファイルをドラッグ&ドロップで入れてください"
echo "何かキーをクリックすると終了します"
pause
:end

if not "%~2" == "" (
shift
echo cycle_check: %1
goto cycle
)

endlocal

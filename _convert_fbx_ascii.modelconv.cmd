@echo off
chcp 65001
setlocal
:first


if exist "%~dp0modelconv.zip" goto cycle
echo "modelconverterを取得中…"
echo "URL: https://github.com/binzume/modelconv"
curl -L -o "%~dp0modelconv.zip" https://github.com/binzume/modelconv/releases/download/v0.3.5/modelconv-v0.3.5-win64.zip
powershell -command `Expand-Archive -Force -Path %~dp0modelconv.zip -DestinationPath %~dp0modelconv

:cycle

set SOURCE=%1
set OUTPUT="%~dpn1-ascii.modelconv.fbx"

echo SOURCE = %SOURCE%
echo OUTPUT = %OUTPUT%

IF NOT DEFINED SOURCE goto error-drop

echo on

"%~dp0modelconv\\modelconv.exe" %SOURCE% %OUTPUT%
goto end

:error-drop

echo FBXファイルをドラッグ＆ドロップで入れてください
pause
:end

echo "変換が完了しました。"
pause

endlocal

@echo off
chcp 65001
setlocal

if exist "%~dp0FbxFormatConverter.exe" goto cycle
echo "FbxFormatConverterを取得中…"
echo "URL: https://github.com/BobbyAnguelov/FbxFormatConverter"
curl -L -o "%~dp0FbxFormatConverter.exe" https://github.com/BobbyAnguelov/FbxFormatConverter/releases/download/v0.3/FbxFormatConverter.exe

:cycle

set SOURCE=%1
set OUTPUT="%~dpn1-ascii.FbxFormatConverter.fbx"

echo SOURCE = %SOURCE%
echo OUTPUT = %OUTPUT%

IF NOT DEFINED SOURCE goto error-drop

"%~dp0FbxFormatConverter.exe" -c %SOURCE% -o %OUTPUT% -ascii
goto end

:error-drop

echo FBXファイルをドラッグ＆ドロップで入れてください
pause
:end

echo "変換が完了しました。"
pause

endlocal

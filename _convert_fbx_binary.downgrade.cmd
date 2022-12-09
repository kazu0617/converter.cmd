@echo off
chcp 65001
setlocal

if exist "%~dp0fbx_binary.exe" goto cycle
echo "fbx変換ソフトを取得中…"
curl -L -o "%~dp0fbx_binary.exe" https://github.com/kazu0617/fbx_sdk_python_sample/releases/download/build1/fbx_binary.exe

set SOURCE=%1
set DEST="%~dpn1-binary.fbx"

echo SOURCE = %SOURCE%
echo DEST = %DEST%

IF NOT DEFINED SOURCE goto error-drop

"%~dp0fbx_binary.exe" %SOURCE% %DEST%
goto end

:error-drop

echo FBXファイルをドラッグ＆ドロップで入れてください
pause
:end

echo "変換が完了しました。"
pause

endlocal

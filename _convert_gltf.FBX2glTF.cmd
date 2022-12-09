@echo off
chcp 65001
setlocal
:first

echo "modelconverterを取得中…"
curl -L -o "%~dp0FBX2glTF-windows-x64.exe" https://github.com/facebookincubator/FBX2glTF/releases/download/v0.9.7/FBX2glTF-windows-x64.exe

:cycle

set VRM=%1
set OUTPUT="%~dpn1.fbx2gltf.gltf"

echo VRM = %VRM%
echo OUTPUT = %OUTPUT%

IF NOT DEFINED VRM goto error-drop

echo off

"%~dp0FBX2glTF-windows-x64.exe" %VRM% -o %OUTPUT%
goto end

:error-drop

echo モデルファイルをドラッグ＆ドロップで入れてください
pause
:end

echo "変換が完了しました。"

pause

endlocal

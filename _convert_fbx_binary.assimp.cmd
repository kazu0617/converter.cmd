@echo off
chcp 65001
setlocal
:first

echo "assimpを取得中…"
curl -L -o "%~dp0assimp.exe" https://github.com/NeosSharedProject/assimp/releases/download/master/assimp.exe
curl -L -o "%~dp0assimp-vc143-mt.dll" https://github.com/NeosSharedProject/assimp/releases/download/master/assimp-vc143-mt.dll

:cycle

set SOURCE=%1
set OUTPUT="%~dpn1-binary.assimp.fbx"

echo SOURCE = %SOURCE%
echo OUTPUT = %OUTPUT%

IF NOT DEFINED SOURCE goto error-drop

"%~dp0assimp.exe" export %SOURCE% %OUTPUT% -ffbx
goto end

:error-drop

echo FBXファイルをドラッグ＆ドロップで入れてください
pause
:end

echo "変換が完了しました。Blenderで読み込めるはずです。"
echo "テキストで編集したい場合は[_convert_fbx_ascii.assimp.bat]を利用してください"
echo "Blenderで使用する場合は別のBatを使用してください"

pause

endlocal

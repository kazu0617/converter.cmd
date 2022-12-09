@echo off
chcp 65001
setlocal
:first

echo "assimpを取得中…"
curl -L -o "%~dp0assimp-bins-windows-latest-cl.zip" https://github.com/NeosSharedProject/assimp/suites/9752106754/artifacts/468245605
powershell -command `Expand-Archive -Force -Path %~dp0assimp-bins-windows-latest-cl.zip -DestinationPath %~dp0assimp
:cycle

set SOURCE=%1
set OUTPUT="%~dpn1-binary.assimp.fbx"

echo SOURCE = %SOURCE%
echo OUTPUT = %OUTPUT%

IF NOT DEFINED SOURCE goto error-drop

"%~dp0assimp\assimp.exe" %SOURCE% %OUTPUT% -ffbx
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

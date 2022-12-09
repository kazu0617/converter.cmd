@echo off
chcp 65001
setlocal
:first

echo "assimpを取得中…"
curl -L -o "%~dp0assimp-bins-windows-latest-cl.zip" https://github.com/NeosSharedProject/assimp/suites/9752106754/artifacts/468245605
powershell -command `Expand-Archive -Force -Path %~dp0assimp-bins-windows-latest-cl.zip -DestinationPath %~dp0assimp

:cycle

set SOURCE=%1
set OUTPUT="%~dpn1-ascii.assimp.fbx"

echo SOURCE = %SOURCE%
echo OUTPUT = %OUTPUT%

IF NOT DEFINED SOURCE goto error-drop

"%~dp0assimp\assimp.exe" %SOURCE% %OUTPUT% -ffbxa
goto end

:error-drop

echo FBXファイルをドラッグ＆ドロップで入れてください
pause
:end

echo "変換が完了しました。VSCodeなどのテキストエディタで確認してください。"
echo "テスクチャの場所が不明な場合はファイルを直接確認した上で、対象の階層に格納してください(直下がオススメ)"
echo "Blenderで使用する場合は[_convert_fbx_binary.assimp.bat]を使用してください"

pause

endlocal

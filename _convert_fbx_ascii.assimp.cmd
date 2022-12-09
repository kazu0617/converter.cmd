@echo off
chcp 65001
setlocal
:first

echo "assimpを取得中…"
curl -L -o "%~dp0assimp.exe" https://github.com/NeosSharedProject/assimp/releases/download/master/assimp.exe
timeout 3

:cycle

set SOURCE=%1
set OUTPUT="%~dpn1-ascii.assimp.fbx"

echo SOURCE = %SOURCE%
echo OUTPUT = %OUTPUT%

IF NOT DEFINED SOURCE goto error-drop

"%~dp0assimp.exe" export %SOURCE% %OUTPUT% -ffbxa
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

@echo on
setlocal
:first


if exist "%~dp0fbx_ascii.exe" goto cycle
echo "fbx変換ソフトを取得中…"
curl -L -o "%~dp0fbx_ascii.exe" https://github.com/kazu0617/fbx_sdk_python_sample/releases/download/build1/fbx_ascii.exe

:cycle

set SOURCE=%1
set OUTPUT="%~dpn1-ascii.fbx"

echo SOURCE = %SOURCE%
echo OUTPUT = %OUTPUT%

IF NOT DEFINED SOURCE goto error-drop

"%~dp0fbx_ascii.exe" %SOURCE% %OUTPUT%
goto end

:error-drop

echo FBXファイルをドラッグ＆ドロップで入れてください
pause
:end

echo "変換が完了しました。テクスチャの場所が直接見えるようになっているはずです。"
echo "テスクチャの場所が不明な場合はファイルを確認した上で、対象の階層に格納してください"
echo "また、Neosに導入する場合はFBX Header Version: 1003まで、FBX Version: 7400以下である必要があります。"
echo "FBXが読み込めない場合はこのツールを使用してFBXをASCII化、その後内容を確認してください。"

pause

endlocal

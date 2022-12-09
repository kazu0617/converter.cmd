@echo off
chcp 65001
setlocal
:first


echo "modelconverterを取得中…"
echo "URL: https://github.com/binzume/modelconv"
curl -L -o "%~dp0modelconv.zip" https://github.com/binzume/modelconv/releases/download/v0.3.5/modelconv-v0.3.5-win64.zip
powershell -command `Expand-Archive -Force -Path %~dp0modelconv.zip -DestinationPath %~dp0modelconv


:cycle

set VRM=%1
set OUTPUT="%~dpn1-modelconv.glb"

echo VRM = %VRM%
echo OUTPUT = %OUTPUT%

IF NOT DEFINED VRM goto error-drop

echo off

"%~dp0modelconv\\modelconv.exe" %VRM% %OUTPUT% > "%~dp0result-%~n1.log"
goto end

:error-drop

echo モデルファイルをドラッグ＆ドロップで入れてください
pause
:end

echo "変換が完了しました。テクスチャの場所が直接見えるようになっているはずです。"
echo "テスクチャの場所が不明な場合はファイルを確認した上で、対象の階層に格納してください"
echo "また、Neosに導入する場合はFBX Header Version: 1003まで、FBX Version: 7400以下である必要があります。"
echo "FBXが読み込めない場合は _convert_fbx_binary_to_ascii を使用してFBXをASCII化、その後内容を確認してください。"

pause

endlocal

@echo off
chcp 65001
setlocal enabledelayedexpansion
:first

set BLENDER_USER_CONFIG=%~dp0%\VRMConvert
set BLENDER_USER_SCRIPTS=%~dp0%\VRMConvert
for /f "usebackq delims=" %%A in (`powershell -command "(Get-ItemProperty HKLM:\Software\\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object DisplayName,DisplayVersion,InstallLocation | Where-Object {$_.DisplayName -eq \"Blender\"} | Sort -Property DisplayVersion | Select-Object -Last 1 ).DisplayVersion"`) do set version=%%A
for /f "usebackq delims=" %%A in (`powershell -command "(Get-ItemProperty HKLM:\Software\\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object DisplayName,DisplayVersion,InstallLocation | Where-Object {$_.DisplayName -eq \"Blender\"} | Sort -Property DisplayVersion | Select-Object -Last 1 ).InstallLocation"`) do set blender=%%A
set blender=%blender:"=%

for /f "usebackq delims=" %%A in (`curl --version`) do set curlresult=%%A
for /f "usebackq delims=" %%A in (`ver`) do set windowsversion=%%A

echo.
echo ===Enviroment Checker===
echo BlenderVersion: %version%
echo BlenderInstallLocation: %blender%
echo CurlResult: %curlresult%
echo WindowsVersion: %windowsversion%


if "%blender%" == "" (
echo "Blenderが検出できませんでした。インストーラをダウンロードし、インストールします"
curl -L -o "%~dp0Blender.msi" https://mirrors.aliyun.com/blender/release/Blender3.2/blender-3.2.2-windows-x64.msi
Blender.msi
goto first
)
set blender='%blender%'

for /f "usebackq delims=" %%A in (`powershell -command "Join-Path %blender% blender.exe"`) do set blender=%%A
set blender="%blender%"
:cycle

set VRM=%1
set OUTPUT="%~dpn1-gltf.glb"

echo.
echo ===Convert Files Checker===
echo BLENDER = %BLENDER%
echo VRM = %VRM%
echo OUTPUT = %OUTPUT%
echo.
echo.

IF NOT DEFINED BLENDER goto error
IF NOT DEFINED VRM goto error-drop

echo ===Convert Start===
%BLENDER% "%~dp0empty.blend"^
 --python "%~dp0fbxconv.py"^
 --background^
 -- --input %VRM%^
 --output %OUTPUT%^
 --maya True
echo ===Convert End===
echo.
echo.

if not exist %OUTPUT% (

    echo "GLBファイルが正常に出力されていません。"
    echo "このパネルをコピーして作者まで連絡してください。"
    echo "(問題のあるファイルの場合、その旨記載があります)"
    echo "上のログを全てコピーした上で作者に連絡してください"
    echo "必ず作者に連絡してください"
    echo "何かキーをクリックすると終了します"
    pause

    goto end

)

echo "変換が完了しファイルが生成されました"
echo.
echo "Neosにインポートするファイル・フォルダは以下の二つです"
echo.
echo %OUTPUT%
echo %~dp1% "に生成された.texturesフォルダ"
echo.
echo.
echo "フォルダの方はテクスチャが正常に紐つかない場合に使用していただき"
echo "テクスチャがglbファイルインポート時にそのまま紐ついた場合は[x]マークで削除してください"
echo "詳しくは[NeosVR日本語非公式Wiki]をご確認ください"
echo.
echo.
echo.
echo "スクリプトでエラーが出てくる場合があります"
echo "もし正常に変換できていない場合は"
echo "上のログを全てコピーした上で作者に連絡してください"
echo "何かキーをクリックすると終了します"
timeout 600
goto end

:error

echo "Blenderを標準のインストール位置から変更しているか、そもそもインストールしていない可能性があります"
echo "インストールしていない場合はBlender3系をインストールお願いします"
echo "何かキーをクリックすると終了します"
pause
goto end

:error-drop
echo "FBXファイルをドラッグ&ドロップで入れてください"
echo "何かキーをクリックすると終了します"
pause
:end

if not "%~2" == "" (
shift
echo cycle_check: %1
goto cycle
)

endlocal

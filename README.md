# Converter for Neos

## これなに

モデルを相互インポートしやすいように色々な形式(主にfbx,gltf)に変換するツールです。  

## 前提ツール

基本なし。自動で入れます。
Blender変換を使用する場合はBlenderだけ入れておいてください。  
Blenderはversion3.0以降でのみ動作します(厳密には2.93 LTSまで動作確認していますが、今から導入する場合は3系をお勧めします)  
もしまだ入れていない方はこちらからどうぞ: https://www.blender.org/download/release/Blender3.2/blender-3.2.2-windows-x64.msi/

## ダウンロード

1. 上にある[Code]をクリックし、[Download zip]から落としてくる
2. Source Code(zip) をダウンロードする

## 使い方

それぞれのbatにvrmファイル / fbxファイル をD&Dする -> 正常に変換できている場合は出力元のファイルがあるフォルダに変換データが出力される
使用できない場合は下の連絡先から連絡 or ここにIssueを立てる

## 使い方(Blender版)

1. (ガイダンスに従い)Blenderをインストールする
2. _convert.batにvrmファイルをD&Dする -> vrmファイルがある場所を確認して、正常に変換できている場合はglbとテクスチャのフォルダが出力される
3. glbが出ない場合はガイダンスに従う
4. 生成されたglbが正常でない場合は `_convert_manual.bat` にvrmファイルを D&D する(ライセンス上問題ない必要があります)

## 備考

- Neosのインポート時の単位(「自動スケール」とかのやつ)は「メートル(m)」
- ライセンスチェックで引っかかったアバターは本当に入れて大丈夫か目視で確認してください
- 複数ファイルも動きます(動かないものもある)。まとめてD&Dしてください
- エラーチェックは随時行っています。GitHubのIssueに直接書いてもらうか、下の連絡先まで連絡お願いします
- 古いWindows10や8.1を使っているとたまに動かないことがあります。お手数ですが最新版のWindows10にアップデートしてください
- 結構雑に集めてます。assimpはまだリリースできていないので頻繁に更新が入ります

## ファイル命名規則

\_convert\_(from_[変換元ファイル名]_to_)[変換先ファイル名]\(\_ascii|\_binary\).[変換ソフト]

ざっくりと変換元ファイルが決まっている場合は from~to~で記載あり
fbxの場合はasciiでもbinaryでもファイル拡張子が同じなのでascii/binaryと記載あり
変換ソフトは使用ライブラリの通り

## 使用ライブラリ

- assimp: [assimp](https://github.com/assimp/assimp) (modified, 3-clause BSD-License)
- modelconv: [modelconv](https://github.com/binzume/modelconv/) (MIT license)
- VRM_Addon_for_Blender: [VRM_Addon_for_Blender](https://github.com/saturday06/VRM_Addon_for_Blender) (MIT license)
- Pythonコード(自改変含む)|downgradeと記載: [fbx_sdk_python_sample](https://github.com/segurvita/fbx_sdk_python_sample) (MIT license) / [フォーク先(自リポ)](https://github.com/kazu0617/fbx_sdk_python_sample) (MIT license)

## 連絡先

- Twitter: @Gameofthebest
- Neos: kazu

## ライセンスについて

一応MITで。そのうちMPLにするかも。

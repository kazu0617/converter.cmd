@echo on
setlocal
:first


if exist "%~dp0fbx_ascii.exe" goto cycle
echo "fbx�ϊ��\�t�g���擾���c"
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

echo FBX�t�@�C�����h���b�O���h���b�v�œ���Ă�������
pause
:end

echo "�ϊ����������܂����B�e�N�X�`���̏ꏊ�����ڌ�����悤�ɂȂ��Ă���͂��ł��B"
echo "�e�X�N�`���̏ꏊ���s���ȏꍇ�̓t�@�C�����m�F������ŁA�Ώۂ̊K�w�Ɋi�[���Ă�������"
echo "�܂��ANeos�ɓ�������ꍇ��FBX Header Version: 1003�܂ŁAFBX Version: 7400�ȉ��ł���K�v������܂��B"
echo "FBX���ǂݍ��߂Ȃ��ꍇ�͂��̃c�[�����g�p����FBX��ASCII���A���̌���e���m�F���Ă��������B"

pause

endlocal

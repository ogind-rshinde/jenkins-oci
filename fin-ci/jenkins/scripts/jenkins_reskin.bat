@ECHO OFF
set PATH=%PATH%;C:\Program Files\Git\cmd
set branch_name=%1
set root=E:\stw
CD /D %root%
git checkout %branch_name%
echo switching to %branch_name%
git pull origin %branch_name% & IF '%ERRORLEVEL%'=='0' (
  ECHO Your branch %branch_name% is up to date
  EXIT
) ELSE (
	ECHO "git pull was unsuccessful"
)
PAUSE
@echo off
::set "repo_path="%userprofile%\sauce\learn-git""
set "repo_path=%userprofile%\sauce\python-arc"
set "readme=readme3.md"
set "long_readme=README2.md"
@REM set "long_readme="%userprofile%\sauce\code_backups\python_exercises\README.md""
set "backup_stash=%userprofile%\sauce\code_backups\python_exercises"

call "cmd /c python helper_1.py %backup_stash%"
pause
setlocal enabledelayedexpansion
for /f "usebackq delims=" %%a in (%long_readme%) do (

    rem each line is in %a
    set "line1=%%a"
    set "line1=!line1:"=\"!"
    echo.
    for /f "delims=" %%b in ('python helper_0.py "!line1!"') do (
        @rem %c holds bool. will redirect to readme if true
        pause
        for /f "tokens=1,* delims= " %%c in ("%%b") do (
            ::echo _%%c_ _%%d_
            if "%%c"=="True" (
                if not "%%d"=="0" set "branch_name=%%d"
                ::echo %%a>>%readme%
                echo. >nul
            
            )            
            if "%%c"=="False" (
                if not "%%d"=="0" (
                    if not !line0!=="" call :main
                    set "file_name=%backup_stash%\%%d"
                ) else (
                    set "line0=!line1!"
                )
            )
        )   
    )
)
pause
exit /b
exit /b


:main
echo.
echo XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
echo branch name _!branch_name!_
echo python file _!file_name!_
echo repo folder _%repo_path%_

echo copying !file_name! %repo_path%...
::copy !file_name! %repo_path%
echo moving  !readme! %repo_path%\readme.md...
::move !readme! %repo_path%\readme.md

echo XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
echo.
exit /b

pause


:main0
pushd "%repo_path%"
git checkout main
git checkout -b !branch_name!
del *.*
popd
copy !file_name! %repo_path%
move !readme! %repo_path%\readme.md
pushd "%repo_path%"
git add .
git commit -m "!branch_name!"
git push
popd

exit /b
endlocal

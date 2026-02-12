@echo off
set "repo_path=%userprofile%\sauce\python-arc"
set "readme=readme3.md"
set "long_readme="README0.md""
set "backup_stash=%userprofile%\sauce\code_backups\python_exercises"
set PYTHONUTF8=1

call "cmd /c python helper_1.py %backup_stash%"
setlocal enabledelayedexpansion
for /f "delims=" %%a in ('findstr /n "^" "README0.md"') do (

    @rem each line is in %a
    set "line1=%%a"
    set "line1a=!line1:"=\"!"
    for /f "delims=" %%b in ('python helper_0.py "!line1a!"') do (
        for /f "tokens=1,* delims= " %%c in ("%%b") do (
            :: %c holds bool. will redirect to readme if true
            echo. >nul
            if "%%c"=="True" (
                if not "%%d"=="0" set "branch_name=%%d"
                set "line1b=!line1:*:=!"
                call :out
            )

            if "%%c"=="False" (
                if not "%%d"=="0" (
                    set "file_name=%backup_stash%\%%d"
                ) else (
                    if not "!line0!"=="%%c" if defined branch_name call :main
                )
            )
        set "line0=%%c"
        )   
    )
)
call:main
echo done
pause
exit /b
exit /b
exit /b

:main0
::variables debug
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo branch name: !branch_name!
echo file name: !file_name!
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo.
exit /b


:out
echo(!line1b! >>%readme%
exit /b


:main
pushd "%repo_path%"
git checkout master >nul
git checkout !branch_name! || git checkout -b !branch_name!
del /Q *.py *.md

popd
echo copying !file_name! %repo_path%...
copy !file_name! %repo_path% >nul

echo moving  %readme% %repo_path%\readme.md...
move %readme% %repo_path%\readme.md >nul
echo.
pushd "%repo_path%"
git add . >nul
git commit -m "!branch_name!" >nul
git push --set-upstream origin !branch_name! >nul
git push
popd
echo.
echo.

exit /b

endlocal

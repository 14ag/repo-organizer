@echo off
set "repo_path=%userprofile%\sauce\python-arc"
set "readme=readme3.md"
set "long_readme="%userprofile%\sauce\code_backups\python_exercises\README.md""
set "backup_stash=%userprofile%\sauce\code_backups\python_exercises"

call "cmd /c python helper_1.py %backup_stash%"
pause
setlocal enabledelayedexpansion
for /f "usebackq delims=" %%a in (%long_readme%) do (

    @rem each line is in %a
    set "line1=%%a"
    set "line1=!line1:"=\"!"
    for /f "delims=" %%b in ('python helper_0.py "!line1!"') do (
        @rem %c holds bool. will redirect to readme if true
        for /f "tokens=1,* delims= " %%c in ("%%b") do (
            if "%%c"=="True" (
                if not "%%d"=="0" set "branch_name=%%d"
                echo %%a>>%readme%
                echo. >nul
            )

            if "%%c"=="False" (
                if not "%%d"=="0" (
                    set "file_name=%backup_stash%\%%d"
                ) else (
                    if not "!line0!"=="%%c" call :main
                )
            )
        set "line0=%%c"    
        )   
    )
    
)
pause
exit /b



:main
pushd "%repo_path%"
git checkout main
git checkout -b !branch_name!
del /Q *.py *.md

popd
echo copying !file_name! %repo_path%...
copy !file_name! %repo_path% >nul

echo moving  !readme! %repo_path%\readme.md...
move !readme! %repo_path%\readme.md >nul

pushd "%repo_path%"
git add .
git commit -m "!branch_name!"
git push
popd

exit /b

endlocal

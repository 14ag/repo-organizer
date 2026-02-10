@echo off
::set "repo_path="%userprofile%\sauce\learn-git""
set "repo_path=readme"
set "is_git_push=0"
set "readme=readme3.md"

call "cmd /c python helper_1.py"

setlocal enabledelayedexpansion
for /f "delims=" %%a in (readme2.md) do (
    rem each line is in %a
    ::echo %%a
    for /f "delims=" %%b in ('python helper_0.py "%%a"') do (
        rem %c holds bool. will redirect to readme if true
        ::echo %%b
        for /f "tokens=1,* delims= " %%c in ("%%b") do (
            ::echo _%%c_ _%%d_
            if "%%c"=="True" (
                if not "%%d"=="0" set "branch_name=%%d"
                echo %%a>>%readme%
            )            
            if "%%c"=="False" (
                if not "%%d"=="0" (
                    set "file_name=test\%%d"
                    set "is_git_push=0"
                ) else (
                    if "%is_git_push%"=="0" (
                       call :main 
                       set "is_git_push=1"
                    )
                )
            )
        )   
    )
    
)
pause
exit /b


:main
echo.
echo XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
echo branch name _!branch_name!_
echo python file _!file_name!_
echo repo folder _%repo_path%_
copy !file_name! %repo_path%
move !readme! %repo_path%\readme.md
echo XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
exit /b







pause
endlocal
exit
:main0
pushd "%repo_path%"
git checkout main
git checkout -b !branch_name!
del *.py *.md
popd
copy !file_name! %repo_path%
copy !readme! %repo_path%
pushd "%repo_path%"
git add .
git commit -m "!branch_name!"
git push
popd





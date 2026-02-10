::@echo off
setlocal enabledelayedexpansion
::set "repo_path="%userprofile%\sauce\learn-git""
set "repo_path=learn-git"
set "py_files_backup=test"

set "readme=readme3.md"

call "cmd /c python helper_1.py"

for /f "delims=" %%a in (readme2.md) do (
    set "line=%%a"
    echo %%a
    for /f "delims=" %%b in ('python helper_0.py "!line!"') do (
        echo %%b
        for /f "tokens=1,* delims= " %%c in ("%%b") do (
            echo %%c_%%d
            if "%%c"=="True" (
                if not "%%d"=="0" set "branch_name=%%d"
                echo !line!>>!readme!
            )            
            if "%%c"=="False" (
                if not "%%d"=="0" (
                    call :main
                    set "file_name=test\%%d"
                )   
            )
        )   
    )
    pause
)

:main
echo XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
echo branch name _!branch_name!_
echo python file _!file_name!_
echo repo folder _!repo_path!_
copy !file_name! !repo_path!
copy !readme! !repo_path!
echo XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
exit /b


:main0
pushd "!repo_path!"
git checkout main
git checkout -b !branch_name!
del *.py *.md
popd
copy !file_name! !repo_path!
copy !readme! !repo_path!
pushd "!repo_path!"
git add .
git commit -m "!branch_name!"
git push
popd


endlocal
pause

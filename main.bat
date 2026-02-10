@echo off
setlocal enabledelayedexpansion
set "py_folder_path="

python helper_1.py

for /f "delims=" %%a in (readme2.md) do (
    set "line=%%a"
    for /f "delims=" %%b in ('python helper_0.py "!line!"') do (
        ::echo %%b
        for /f "tokens=1,* delims= " %%c in ("%%b") do (
            ::echo %%c_%%d
            if "%%c"=="True" (
                if not "%%d"=="0" set "branch_name=%%d"
                echo !line!>>!readme!
            )            
            if "%%c"=="False" (
                if not "%%d"=="0" (
                    call main
                    set "file_name=%%d"
                )
            )            
        )
    )    
)


:main
::gh create branch
::gh checkout branch
:: del *.py *.md
copy !file_name! !repo_folder!!file_name!
copy !readme! !repo_folder!!readme!
::gh commit
::git push
::


endlocal
pause

@echo off
setlocal enabledelayedexpansion
set "py_folder_path="


for /f "delims=" %%a in (readme2.md) do (
    set "line=%%a"
    for /f "delims=" %%b in ('python helper_0.py "!line!"') do (
        ::echo %%b
        for /f "tokens=1,* delims= " %%c in ("%%b") do (
            ::echo %%c_%%d
            if not "%%d"=="0" (
                set "branch_name=%%d"
                for /f "delims=" %%e in ('python helper_0.py "%%d"') do (
                    set "py_file=%%e"

                )
            )
        )

    )
)
endlocal
pause
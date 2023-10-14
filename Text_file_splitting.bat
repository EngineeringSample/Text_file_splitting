@echo off
setlocal enabledelayedexpansion

REM Set the input file name and output file name prefix
set "input_file=original_file.txt"
set "output_prefix=split_file_"

REM Set the number of lines per split file
set "lines_per_file=100"

REM Initialize counters
set "file_count=1"
set "line_count=0"
set "output_file="

REM Create the first split file
set "output_file=!output_prefix!!file_count!.txt"
type nul > "!output_file!"

REM Read the input file line by line and write to split files
for /f "tokens=*" %%a in (%input_file%) do (
    echo %%a >> "!output_file!"
    set /a "line_count+=1"
    
    REM If the line count reaches the limit for each split file, create the next one
    if !line_count! equ %lines_per_file% (
        set /a "file_count+=1"
        set "output_file=!output_prefix!!file_count!.txt"
        type nul > "!output_file!"
        set "line_count=0"
    )
)

echo Successfully split into %file_count% files.

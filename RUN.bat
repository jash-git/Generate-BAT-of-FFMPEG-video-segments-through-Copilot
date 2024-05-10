@echo off
setlocal enabledelayedexpansion

REM 設定輸出檔案名稱的格式
set "filename=0001"
set "extension=mp4"

REM 設定每個分割檔案的長度（以秒為單位）
set /a "segment_length=2*60"

REM 設定起始時間為0
set /a "start_time=0"

REM 設定總影片長度（以秒為單位）
set /a "total_length=8*60+8"

REM 使用迴圈來分割影片
:loop
if !start_time! geq !total_length! (
    echo 完成影片分割。
    goto :eof
)

REM 計算下一個檔案的起始時間
set /a "next_start_time=!start_time!+!segment_length!"

REM 執行FFMPEG命令來分割影片
ffmpeg -i videoplayback.mp4 -ss !start_time! -t !segment_length! -c copy !filename!.!extension!

REM 更新檔案名稱為下一個序號
set /a "filename_num=1%filename% + 1"
set "filename=!filename_num:~1!"

REM 更新起始時間為下一個分段的起始時間
set /a "start_time=!next_start_time!"

goto loop
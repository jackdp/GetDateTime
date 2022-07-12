@echo off

set PATH=%JP_MyToolsDir%;%JP_ToolsDir%;%PATH%

rem --------------- common -----------------
set AppName=GetDateTime
set AppVer=1.0
set AppFullName=%AppName% %AppVer%
set AppName_=GetDateTime
set AppUrl=https://github.com/jackdp/GetDateTime



rem ----------------- Windows 32 & 64-bit ---------------------
set AppExe32=GetDateTime32.exe
set AppExe64=GetDateTime64.exe
set ArchFile=%AppName_%.zip
set Files=%AppExe32% %AppExe64% repository.url test_run.bat Readme.md vx_images\*

set CreateRelease=7z a -tzip -mx=9 %ArchFile% %Files%


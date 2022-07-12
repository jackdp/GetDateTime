@echo off


call globals.bat

if exist %ArchFile% del %ArchFile%

%CreateRelease%


@echo off



:: Save the current time to the variable (1)
echo ======= Method 1 - default template (no spaces) =======

for /f %%i in ('GetDateTime32.exe') do set dt=%%i
echo %dt%


echo;
echo;



:: Save the current time to the variable (2)
echo ============ Method 2 - template with spaces ============

set temp_file=%TMP%\_temp_%RANDOM%.txt
GetDateTime32.exe "Date: $Y.$M.$D   Time: $H:$MIN:$S.$MS" > %temp_file%
set /p dt=<%temp_file%
del %temp_file%
echo %dt%


echo;
echo;



echo ============= Backup ==============


for /f %%i in ('GetDateTime32.exe') do set dt=%%i
set BackupFile=backup_%dt%.7z
set SevenZip=7z.exe
set Files=*.pas *.pp *.dpr *.lpr *.dproj *.lpi *.dfm *.lfm *.res
set ComprThreads=4
set ComprLevel=8

%SevenZip% a -r -mx=%ComprLevel% -t7z -m0=LZMA2 -scsUTF-8 -mmt=%ComprThreads% -mtc=on -mtm=on -mta=on %BackupFile% %Files%


pause

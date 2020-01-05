@ECHO OFF
CLS

RD /S /Q .\Deployment

MD .\Deployment

DEL Source\EWSPDI\bin\Release\*.nupkg
DEL Source\EWSPDIData\bin\Release\*.nupkg
DEL Source\EWSPDIWeb\bin\Release\*.nupkg
DEL Source\EWSPDIWinForms\bin\Release\*.nupkg

IF EXIST "%ProgramFiles(x86)%\Microsoft Visual Studio\2017\Community\MSBuild\15.0" SET "MSBUILD=%ProgramFiles(x86)%\Microsoft Visual Studio\2017\Community\MSBuild\15.0\bin\MSBuild.exe"
IF EXIST "%ProgramFiles(x86)%\Microsoft Visual Studio\2017\Professional\MSBuild\15.0" SET "MSBUILD=%ProgramFiles(x86)%\Microsoft Visual Studio\2017\Professional\MSBuild\15.0\bin\MSBuild.exe"
IF EXIST "%ProgramFiles(x86)%\Microsoft Visual Studio\2017\Enterprise\MSBuild\15.0" SET "MSBUILD=%ProgramFiles(x86)%\Microsoft Visual Studio\2017\Enterprise\MSBuild\15.0\bin\MSBuild.exe"
IF EXIST "%ProgramFiles(x86)%\Microsoft Visual Studio\2019\Community\MSBuild\Current" SET "MSBUILD=%ProgramFiles(x86)%\Microsoft Visual Studio\2019\Community\MSBuild\Current\bin\MSBuild.exe"
IF EXIST "%ProgramFiles(x86)%\Microsoft Visual Studio\2019\Professional\MSBuild\Current" SET "MSBUILD=%ProgramFiles(x86)%\Microsoft Visual Studio\2019\Professional\MSBuild\Current\bin\MSBuild.exe"
IF EXIST "%ProgramFiles(x86)%\Microsoft Visual Studio\2019\Enterprise\MSBuild\Current" SET "MSBUILD=%ProgramFiles(x86)%\Microsoft Visual Studio\2019\Enterprise\MSBuild\Current\bin\MSBuild.exe"

"%MSBUILD%" /nologo /v:m /m Source\EWSPDI.sln /t:Clean;Build "/p:Configuration=Release;Platform=Any CPU"

COPY Source\EWSPDI\bin\Release\*.nupkg .\Deployment
COPY Source\EWSPDIData\bin\Release\*.nupkg .\Deployment
COPY Source\EWSPDIWeb\bin\Release\*.nupkg .\Deployment
COPY Source\EWSPDIWinForms\bin\Release\*.nupkg .\Deployment

IF NOT "%SHFBROOT%"=="" "%MSBUILD%" /nologo /v:m Doc\EWSoftwarePDI.sln /t:Clean;Build "/p:Configuration=Release;Platform=Any CPU"

IF "%SHFBROOT%"=="" ECHO **** Sandcastle help file builder not installed.  Skipping help build. ****

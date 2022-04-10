@echo off

if "%VCVARS_INITIALIZED%"=="" (
    call "C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build\vcvars32.bat"
    set VCVARS_INITIALIZED=default 1
)

if not exist build mkdir build
pushd build
del * /Q

ml.exe /W3 /WX /c /Zi ..\strlen.asm
cl.exe /W3 /WX /Od /Zi ..\test_strlen.cpp strlen.obj

popd

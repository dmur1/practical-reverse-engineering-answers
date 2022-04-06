@echo off

if "%VCVARS_INITIALIZED%"=="" (
    call "C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build\vcvars32.bat"
    set VCVARS_INITIALIZED=default 1
)

if not exist build mkdir build
pushd build
del * /Q

cl.exe /W3 /WX /c /O2 /Oy- /D_UNICODE /GS- ..\decompiled.cpp
dumpbin.exe /disasm decompiled.obj > code.asm

popd

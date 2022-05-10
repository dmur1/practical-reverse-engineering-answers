@echo off

if "%VCVARS_INITIALIZED%"=="" (
    call "C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build\vcvars32.bat"
    set VCVARS_INITIALIZED=default 1
)

if not exist build mkdir build
pushd build
del * /Q

ml.exe /W3 /WX /c /Zi ..\contains_zero_byte.asm
cl.exe /W3 /WX /Od /Zi ..\contains_zero_byte_test.cpp contains_zero_byte.obj

ml.exe /W3 /WX /c /Zi ..\strlen.asm
cl.exe /W3 /WX /Od /Zi ..\test_strlen.cpp strlen.obj

ml.exe /W3 /WX /c /Zi ..\strchr.asm
cl.exe /W3 /WX /Od /Zi ..\test_strchr.cpp strchr.obj

ml.exe /W3 /WX /c /Zi ..\memcpy.asm
cl.exe /W3 /WX /Od /Zi ..\test_memcpy.cpp memcpy.obj

ml.exe /W3 /WX /c /Zi ..\memset.asm
cl.exe /W3 /WX /Od /Zi ..\test_memset.cpp memset.obj

ml.exe /W3 /WX /c /Zi ..\strcmp.asm
cl.exe /W3 /WX /Od /Zi ..\test_strcmp.cpp strcmp.obj

popd

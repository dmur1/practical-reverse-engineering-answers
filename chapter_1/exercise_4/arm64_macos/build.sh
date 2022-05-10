rm -r ./build
mkdir build
cd ./build

clang -o contains_zero_byte_test ../contains_zero_byte_test.cpp ../contains_zero_byte.asm

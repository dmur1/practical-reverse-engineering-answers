#include <stdio.h>
#include <stdint.h>

extern "C" int contains_zero_byte_( int x );

int contains_zero_byte( int x ) {
    return ( ( ( x - 0x01010101 ) & ~x ) & 0x80808080 ) ? 1 : 0;
}

int main() {
    printf( "%u\n", contains_zero_byte_( 0x01010101 ) );
    printf( "%u\n", contains_zero_byte_( 0x00010101 ) );
    printf( "%u\n", contains_zero_byte_( 0x01000101 ) );
    printf( "%u\n", contains_zero_byte_( 0x01010001 ) );
    printf( "%u\n", contains_zero_byte_( 0x01010100 ) );

    printf( "\n" );

    printf( "%u\n", contains_zero_byte( 0x01010101 ) );
    printf( "%u\n", contains_zero_byte( 0x00010101 ) );
    printf( "%u\n", contains_zero_byte( 0x01000101 ) );
    printf( "%u\n", contains_zero_byte( 0x01010001 ) );
    printf( "%u\n", contains_zero_byte( 0x01010100 ) );

    return 0;
}

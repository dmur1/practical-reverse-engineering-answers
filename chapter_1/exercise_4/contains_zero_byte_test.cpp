#include <stdio.h>
#include <stdint.h>

extern "C" int contains_zero_byte_( int x );

int contains_zero_byte( int x ) {
    return ( x - 0x01010101 ) & ~x & 0x80808080;
}

int main() {
    printf( "%u\n", contains_zero_byte_( 0 ) );
    printf( "%u\n", contains_zero_byte_( 1 ) );
    printf( "%u\n", contains_zero_byte_( 0x0100 ) );
    printf( "%u\n", contains_zero_byte_( 0x010000 ) );
    printf( "%u\n", contains_zero_byte_( 0x01000000 ) );
    printf( "%u\n", contains_zero_byte_( 0x01010100 ) );
    printf( "%u\n", contains_zero_byte_( 0x01010101 ) );
    printf( "%u\n", contains_zero_byte_( 0x00010101 ) );
    printf( "%u\n", contains_zero_byte_( 0x01000101 ) );
    printf( "%u\n", contains_zero_byte_( 0x01010001 ) );
    printf( "%u\n", contains_zero_byte_( 0x01010100 ) );

    printf( "\n" );

    printf( "%u\n", contains_zero_byte( 0 ) );
    printf( "%u\n", contains_zero_byte( 1 ) );
    printf( "%u\n", contains_zero_byte( 0x0100 ) );
    printf( "%u\n", contains_zero_byte( 0x010000 ) );
    printf( "%u\n", contains_zero_byte( 0x01000000 ) );
    printf( "%u\n", contains_zero_byte( 0x01010100 ) );
    printf( "%u\n", contains_zero_byte( 0x01010101 ) );
    printf( "%u\n", contains_zero_byte( 0x00010101 ) );
    printf( "%u\n", contains_zero_byte( 0x01000101 ) );
    printf( "%u\n", contains_zero_byte( 0x01010001 ) );
    printf( "%u\n", contains_zero_byte( 0x01010100 ) );

    for ( uint32_t i = 0; i < 0xFFFFFFFF; ++i ) {
        if ( ( ( ( i >> 24 ) & 0xFF ) == 0 ) || ( ( ( i >> 16 ) & 0xFF ) == 0 )
            || ( ( ( i >> 8 ) & 0xFF ) == 0 ) || ( ( i & 0xFF ) == 0 ) ) {
            if ( !contains_zero_byte_( i ) )
                __debugbreak();
        }
        else {
            if ( contains_zero_byte_( i ) )
                __debugbreak();
        }
    }

    return 0;
}

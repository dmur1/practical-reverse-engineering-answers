#include <stdio.h>
#include <stdlib.h>
#include <string.h>

extern "C" void* memcpy_1( void* dst, void* src, size_t n );
extern "C" void* memcpy_2( void* dst, void* src, size_t n );
extern "C" void* memcpy_3( void* dst, void* src, size_t n );
extern "C" void* memcpy_4( void* dst, void* src, size_t n );
extern "C" void* memcpy_5( void* dst, void* src, size_t n );

int main( int argc, char** argv ) {
    void* src = malloc( 4096 );
    void* dst = malloc( 4096 );

    memset( src, 0xDA, 4096 );
    memset( dst, 0x00, 4096 );
    memcpy_1( dst, src, 4096 );
    for ( int i = 0; i < 4096; ++i ) {
        if ( *( ( char* )dst + i ) != *( ( char* )src + i ) )
            __debugbreak();
    }

    memset( src, 0xDA, 4096 );
    memset( dst, 0x00, 4096 );
    memcpy_2( dst, src, 4096 );
    for ( int i = 0; i < 4096; ++i ) {
        if ( *( ( char* )dst + i ) != *( ( char* )src + i ) )
            __debugbreak();
    }

    memset( src, 0xDA, 4096 );
    memset( dst, 0x00, 4096 );
    memcpy_3( dst, src, 4096 );
    for ( int i = 0; i < 4096; ++i ) {
        if ( *( ( char* )dst + i ) != *( ( char* )src + i ) )
            __debugbreak();
    }

    memset( src, 0xDA, 4096 );
    memset( dst, 0x00, 4096 );
    memcpy_4( dst, src, 4096 );
    for ( int i = 0; i < 4096; ++i ) {
        if ( *( ( char* )dst + i ) != *( ( char* )src + i ) )
            __debugbreak();
    }

    memset( src, 0xDA, 4096 );
    memset( dst, 0x00, 4096 );
    memcpy_5( dst, src, 4096 );
    for ( int i = 0; i < 4096; ++i ) {
        if ( *( ( char* )dst + i ) != *( ( char* )src + i ) )
            __debugbreak();
    }

    return 0;
}

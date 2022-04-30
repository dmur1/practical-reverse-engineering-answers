#include <stdint.h>
#include <stdio.h>
#include <malloc.h>

extern "C" void* memset_1( void* s, int c, size_t n );
extern "C" void* memset_2( void* s, int c, size_t n );
extern "C" void* memset_3( void* s, int c, size_t n );
extern "C" void* memset_4( void* s, int c, size_t n );

int main() {
    void* dst1 = malloc( 4096 );
    memset_1( dst1, 0xFF, 4096 );
    for ( int i = 0; i < 4096; ++i ) {
        if ( *( ( unsigned char* )dst1 + i ) != 0xFF )
            __debugbreak();
    }

    void* dst2 = malloc( 4096 );
    memset_2( dst2, 0xFF, 4096 );
    for ( int i = 0; i < 4096; ++i ) {
        if ( *( ( unsigned char* )dst2 + i ) != 0xFF )
            __debugbreak();
    }

    void* dst3 = malloc( 4096 );
    memset_3( dst3, 0xFF, 4096 );
    for ( int i = 0; i < 4096; ++i ) {
        if ( *( ( unsigned char* )dst3 + i ) != 0xFF )
            __debugbreak();
    }

    void* dst4 = malloc( 4096 );
    memset_4( dst4, 0xFF, 4096 );
    for ( int i = 0; i < 4096; ++i ) {
        if ( *( ( unsigned char* )dst4 + i ) != 0xFF )
            __debugbreak();
    }

    return 0;
}

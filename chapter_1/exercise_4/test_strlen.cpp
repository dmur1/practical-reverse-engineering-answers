#include <stdio.h>

extern "C" size_t strlen_1( char const* str );
extern "C" size_t strlen_2( char const* str );
extern "C" size_t strlen_3( char const* str );
extern "C" size_t strlen_4( char const* str );

int main( int argc, char** argv ) {
    printf( "%d\n", ( int )strlen_1( "" ) ); // 0
    printf( "%d\n", ( int )strlen_1( "1" ) ); // 1
    printf( "%d\n", ( int )strlen_1( "22" ) ); // 2
    printf( "%d\n", ( int )strlen_1( "Hello, world!\n" ) ); // 14

    printf( "%d\n", ( int )strlen_2( "" ) ); // 0
    printf( "%d\n", ( int )strlen_2( "1" ) ); // 1
    printf( "%d\n", ( int )strlen_2( "22" ) ); // 2
    printf( "%d\n", ( int )strlen_2( "Hello, world!\n" ) ); // 14

    printf( "%d\n", ( int )strlen_3( "" ) ); // 0
    printf( "%d\n", ( int )strlen_3( "1" ) ); // 1
    printf( "%d\n", ( int )strlen_3( "22" ) ); // 2
    printf( "%d\n", ( int )strlen_3( "Hello, world!\n" ) ); // 14

    printf( "%d\n", ( int )strlen_4( "" ) ); // 0
    printf( "%d\n", ( int )strlen_4( "1" ) ); // 1
    printf( "%d\n", ( int )strlen_4( "22" ) ); // 2
    printf( "%d\n", ( int )strlen_4( "Hello, world!\n" ) ); // 14

    return 0;
}

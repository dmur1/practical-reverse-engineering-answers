#include <stdio.h>

extern "C" char* strchr_1( char const* str, int ch );
extern "C" char* strchr_2( char const* str, int ch );
extern "C" char* strchr_3( char const* str, int ch );
extern "C" char* strchr_4( char const* str, int ch );

int main( int argc, char** argv ) {
    printf( "%s\n", strchr_1( "Test", 'z' ) );
    printf( "%s\n", strchr_1( "Test", 'e' ) );
    printf( "%s\n", strchr_1( "Test", 's' ) );
    printf( "%s\n", strchr_1( "Test", 't' ) );
    printf( "%s\n", strchr_1( "This is a slightly longer test!", 'y' ) );
    printf( "%s\n", strchr_1( "This is a slightly longer test!", ' ' ) );
    printf( "%s\n", strchr_1( "", 'y' ) );
    printf( "%s\n", strchr_1( "", '\0' ) );
    printf( "%s\n", strchr_1( "This is a slightly longer test! that became even longer... very long in fact!", 'v' ) );
    printf( "%s\n", strchr_1( "This is a slightly longer test! that became even longer... very long in fact!", 'f' ) );

    printf( "%s\n", strchr_2( "Test", 'z' ) );
    printf( "%s\n", strchr_2( "Test", 'e' ) );
    printf( "%s\n", strchr_2( "Test", 's' ) );
    printf( "%s\n", strchr_2( "Test", 't' ) );
    printf( "%s\n", strchr_2( "This is a slightly longer test!", 'y' ) );
    printf( "%s\n", strchr_2( "This is a slightly longer test!", ' ' ) );
    printf( "%s\n", strchr_2( "", 'y' ) );
    printf( "%s\n", strchr_2( "", '\0' ) );
    printf( "%s\n", strchr_2( "This is a slightly longer test! that became even longer... very long in fact!", 'v' ) );
    printf( "%s\n", strchr_2( "This is a slightly longer test! that became even longer... very long in fact!", 'f' ) );

    printf( "%s\n", strchr_3( "Test", 'z' ) );
    printf( "%s\n", strchr_3( "Test", 'e' ) );
    printf( "%s\n", strchr_3( "Test", 's' ) );
    printf( "%s\n", strchr_3( "Test", 't' ) );
    printf( "%s\n", strchr_3( "This is a slightly longer test!", 'y' ) );
    printf( "%s\n", strchr_3( "This is a slightly longer test!", ' ' ) );
    printf( "%s\n", strchr_3( "", 'y' ) );
    printf( "%s\n", strchr_3( "", '\0' ) );
    printf( "%s\n", strchr_3( "This is a slightly longer test! that became even longer... very long in fact!", 'v' ) );
    printf( "%s\n", strchr_3( "This is a slightly longer test! that became even longer... very long in fact!", 'f' ) );

    printf( "%s\n", strchr_4( "Test", 'T' ) );
    printf( "%s\n", strchr_4( "Test", 'e' ) );
    printf( "%s\n", strchr_4( "Test", 's' ) );
    printf( "%s\n", strchr_4( "Test", 't' ) );
    printf( "%s\n", strchr_4( "This is a slightly longer test!", 'y' ) );
    printf( "%s\n", strchr_4( "This is a slightly longer test!", ' ' ) );
    printf( "%s\n", strchr_4( "", 'y' ) );
    printf( "%s\n", strchr_4( "", '\0' ) );
    printf( "%s\n", strchr_4( "This is a slightly longer test! that became even longer... very long in fact!", 'v' ) );
    printf( "%s\n", strchr_4( "This is a slightly longer test! that became even longer... very long in fact!", 'f' ) );

    return 0;
}

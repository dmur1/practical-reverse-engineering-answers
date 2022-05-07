#include <stdio.h>
#include <string.h>

extern "C" int strcmp_1( char const* s1, char const* s2 );
extern "C" int strcmp_2( char const* s1, char const* s2 );

int main() {
    printf( "%d\n", strcmp( "a", "a" ) );
    printf( "%d\n", strcmp( "a", "b" ) );
    printf( "%d\n", strcmp( "b", "a" ) );
    printf( "%d\n", strcmp( "test", "test" ) );
    printf( "%d\n", strcmp( "test", "zest" ) );
    printf( "%d\n", strcmp( "zest", "zest" ) );
    printf( "\n" );

    printf( "%d\n", strcmp_1( "a", "a" ) );
    printf( "%d\n", strcmp_1( "a", "b" ) );
    printf( "%d\n", strcmp_1( "b", "a" ) );
    printf( "%d\n", strcmp_1( "test", "test" ) );
    printf( "%d\n", strcmp_1( "test", "zest" ) );
    printf( "%d\n", strcmp_1( "zest", "zest" ) );
    printf( "\n" );

    printf( "%d\n", strcmp_2( "a", "a" ) );
    printf( "%d\n", strcmp_2( "a", "b" ) );
    printf( "%d\n", strcmp_2( "b", "a" ) );
    printf( "%d\n", strcmp_2( "test", "test" ) );
    printf( "%d\n", strcmp_2( "test", "zest" ) );
    printf( "%d\n", strcmp_2( "zest", "zest" ) );
    return 0;
}

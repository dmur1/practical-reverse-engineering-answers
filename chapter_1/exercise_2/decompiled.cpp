#include <Windows.h>
#include <intrin.h>
#include <tlhelp32.h>

#pragma pack( 1 )
struct IDTR {
    SHORT limit;
    DWORD base;
};

// as an example
char const* process_name = "explorer.exe";

BOOL __stdcall
DllMain( HINSTANCE hinstDLL, DWORD fwdReason, LPVOID lpvReserved ) {
    IDTR idtr;
    __sidt( &idtr );

    if ( ( idtr.base <= 0x8003F400 ) || ( idtr.base > 0x80047400 ) )
        return 0;

    PROCESSENTRY32 process_entry;

    // the following could also be memset, but this produces closer code to the sample
    process_entry.dwSize = 0;
    for ( int i = 0; i < ( sizeof( PROCESSENTRY32 ) - 4 ) / sizeof( int ); ++i )
        *( ( ( int* )&process_entry.cntUsage ) + i ) = 0;

    HANDLE snapshot = CreateToolhelp32Snapshot( TH32CS_SNAPPROCESS, 0 );
    if ( snapshot == INVALID_HANDLE_VALUE )
        return 0;

    process_entry.dwSize = 296;

    DWORD process_id = fwdReason;
    DWORD process_parent_id = fwdReason;

    if ( Process32First( snapshot, &process_entry ) ) {
        do {
            if ( _stricmp( process_name, process_entry.szExeFile ) == 0 )
            {
                process_parent_id = process_entry.th32ParentProcessID;
                process_id = process_entry.th32ProcessID;
                break;
            }
        } while ( Process32Next( snapshot, &process_entry ) );
    }

    if ( process_parent_id == process_id )
    {
        if ( fwdReason == DLL_PROCESS_ATTACH )
        {
            CreateThread( 0, 0, 0, (LPTHREAD_START_ROUTINE)0x100032D0, 0, 0 );
        }

        return true;
    }

    return 0;
}

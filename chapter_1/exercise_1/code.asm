; BOOL __stdcall DllMain( HINSTANCE hinstDLL, DWORD fdwReason, LPVOID lpvReserved )
_DllMain@12 proc near
    push        ebp                         ; save the stack base pointer
    mov         ebp, esp                    ; set the stack base pointer to the current stack pointer
    sub         esp, 130h                   ; make space on the stack for up to 0x130 ( 304 ) bytes of locals
    push        edi                         ; save the value in the non-volatile register edi
    sidt        fword ptr [ebp-8]           ; store interrupt descriptor table register ( 6 bytes )
    mov         eax, [ebp-6]                ; store the base address ( upper 4 bytes of idtr ) in eax
    cmp         eax, 8003F400h              ;
    jbe         short loc_10001C88          ; if ( idtr.base <= 0x8003F400 ) { jmp loc_10001C88; }
    cmp         eax, 80047400h              ;
    jnb         short loc_10001C88          ; if ( idtr.base > 0x80047400 ) { jmp loc_10001C88; }
    xor         eax, eax                    ; eax = 0
    pop         edi                         ; restore the value to the non-volatile register edi ( line 6 )
    mov         esp, ebp                    ; reset the stack pointer to the address of the stack base pointer
    pop         ebp                         ; restore the stack base pointer ( line 3 )
    retn        0Ch                         ; return, popping 12 bytes off the stack for the 3 parameters passed to the function
loc_10001C88:                               ; we reach this point if the idtr base address is between two values
    xor         eax, eax                    ; eax = 0
    mov         ecx, 49h                    ; ecx = 73
    lea         edi, [ebp-12Ch]             ; edi = &process_entry.cntUsage
    mov         dword ptr [ebp-130h], 0     ; process_entry.dwSize = 0
    push        eax                         ; DWORD th32ProcessID = 0 = the current process
    push        2                           ; DWORD dwFlags = 0x2 = TH32CS_SNAPPROCESS
    rep         stosd                       ; memset( &process_entry.cntUsage, 0, sizeof( PROCESSENTRY32 ) - sizeof( process_entry.dwSize ) )
    call        CreateToolhelp32Snapshot    ;
    mov         edi, eax                    ; edi = HANDLE snapshot = CreateToolhelp32Snapshot( TH32CS_SNAPPROCESS, 0 )
    cmp         edi, 0FFFFFFFFh             ;
    jnz         short loc_10001CB9          ; if ( snapshot != INVALID_HANDLE_VALUE ) { jmp loc_10001CB9; }
    xor         eax, eax                    ; eax = 0
    pop         edi                         ; restore the value to the non-volatile register edi ( line 6 )
    mov         esp, ebp                    ; reset the stack pointer to the address of the stack base pointer
    pop         ebp                         ; restore the stack base pointer ( line 3 )
    ret         0Ch                         ; return, popping 12 bytes off the stack for the 3 parameters passed to the function
loc_10001CB9:                               ; we reach this point if CreateToolhelp32Snapshot returned a valid value
    lea         eax, [ebp-130h]             ; eax = (LPPROCESSENTRY32)&process_entry
    push        esi                         ; save the value in the non-volatile register esi
    push        eax                         ; LPPROCESSENTRY32 lppe
    push        edi                         ; HANDLE hSnapshot
    mov         [ebp-130h], 128h            ; process_entry.dwSize = 296
    call        Process32First              ;
    test        eax, eax                    ;
    jnz         short loc_10001D24          ; if ( !Process32First( hSnapshot, &process_entry ) ) { jmp loc_10001D24; }
    mov         esi, ds:_stricmp            ;
    lea         ecx, [ebp-10Ch]             ; char* process_name = (CHAR*)&process_entry.szExeFile[0]
    push        10007C50h                   ; char* process_name_to_search_for
    push        ecx                         ; char* process_name
    call        esi                         ; stricmp( process_name, process_name_to_search_for )
    add         rsp, 8                      ; restore 8 bytes to the stack after above call ( line 48 )
    test        eax, eax                    ;
    jz          short loc_10001D16          ; if ( stricmp( process_name, process_name_to_search_for ) == 0 ) { jmp loc_10001D16; }
loc_10001CF0:                               ; we reach this if the first found process didn't match our process name to search for
    lea         edx, [ebp-130h]             ; edx = (LPPROCESSENTRY32)&process_entry
    push        edx                         ; LPPROCESSENTRY32 lppe
    push        edi                         ; HANDLE hSnapshot
    call        Process32Next               ;
    test        eax, eax                    ;
    jz          short loc_10001D24          ; if ( !Process32Next( hSnapshot, &process_entry ) ) { jmp loc_10001D24; }
    lea         eax, [ebp-10Ch]             ; char* process_name = (CHAR*)&process_entry.szExeFile[0]
    push        10007C50h                   ; char* process_name_to_search_for
    push        eax                         ; char* process_name
    call        esi                         ; stricmp( process_name, process_name_to_search_for )
    add         esp, 8                      ; restore 8 bytes to the stack after above call ( line 62 )
    test        eax, eax                    ;
    jnz         short loc_10001CF0          ; if ( stricmp( process_name, process_name_to_search_for ) != 0 ) { jmp loc_10001CF0; }
loc_10001D16:                               ; we reach this point if we found a match for a process with our name
    mov         eax, [ebp-118h]             ; DWORD th32ParentProcessID
    mov         ecx, [ebp-128h]             ; DWORD th32ProcessID
    jmp         short loc_10001D2A          ;
loc_10001D24:                               ; we reach this point when there are no more processes to enumerate
    mov         eax, [ebp+0Ch]              ; DWORD fdwReason
    mov         ecx, [ebp+0Ch]              ; DWORD fdwReason
loc_10001D2A:                               ; we reach this point if we found a match for a process with our name
    cmp         eax, ecx                    ;
    pop         esi                         ; restore value to non-volatile register esi ( line 37 )
    jnz         short loc_10001D38          ; if ( eax == ecx ) { jmp loc_10001D38; } 
    xor         eax, eax                    ; eax = 0
    pop         edi                         ; restore the value to the non-volatile register edi ( line 6 )
    mov         esp, ebp                    ; reset the stack pointer to the address of the stack base pointer
    pop         ebp                         ; restore the stack base pointer ( line 3 )
    ret         0Ch                         ; return, popping 12 bytes off the stack for the 3 parameters passed to the function
loc_10001D38:                               ; we reach here if we found a match for a process with out name
    mov         eax, [ebp+0Ch]              ; DWORD fdwReason
    dec         eax                         ;
    jnz         short loc_10001D53          ; if ( fdwReason == DLL_PROCESS_ATTACH ) { jmp loc_10001D53; }
    push        0                           ; LPDWORD lpThreadId
    push        0                           ; DWORD dwCreationFlags
    push        0                           ; LPVOID lpParameter
    push        100032D0h                   ; LPTHREAD_START_ROUTINE lpStartAddress
    push        0                           ; SIZE_T dwStackSize
    push        0                           ; LPSECURITY_ATTRIBUTES lpThreadAttributes
    call        ds:CreateThread             ; note that we don't check the return value of CreateThread
loc_10001D53:
    mov         eax, 1                      ; return 1;
    pop         edi                         ; restore the value to the non-volatile register edi ( line 6 )
    mov         esp, ebp                    ; reset the stack pointer to the address of the stack base pointer
    pop         ebp                         ; restore the stack base pointer ( line 3 )
    ret         0Ch                         ; return, popping 12 bytes off the stack for the 3 parameters passed to the function
_DllMain@12 endp

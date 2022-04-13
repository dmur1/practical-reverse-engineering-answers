.model flat
.code

; char* strchr_1( char const* str, int ch )
; using repne scasb
_strchr_1 proc
    push        edi
    push        ebx
    mov         edi, dword ptr [esp+12]         ; char const* str
    mov         ebx, dword ptr [esp+16]         ; int ch
    xor         eax, eax                        ; search for 0
    mov         ecx, -1                         ; scan up to 0xFFFFFFFF
    repne scasb                                 ; search for '\0'
    not         ecx                             ; strlen( str ) + 1
    test        ebx, ebx                        ;
    jz          _strchr_1_loc_2                 ; if ( ch != '\0' )
    sub         edi, ecx                        ; char const* str
    mov         eax, ebx                        ; int ch
    repne scasb                                 ; search for ch
    xor         eax, eax
    sub         edi, 1                          ; &str[ found ]
    test        ecx, ecx                        ;
    cmovnz      eax, edi                        ; return found ? &str[ found ] : 0
_strchr_1_loc_1:
    pop         ebx
    pop         edi
    ret
_strchr_1_loc_2:
    lea         eax, [edi+ecx-1]                ;
    jmp         _strchr_1_loc_1                 ; return &str[ strlen( str ) + 1 ]
_strchr_1 endp

end

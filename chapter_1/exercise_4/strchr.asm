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
    jnz         _strchr_1_loc_1                 ; if ( ch != '\0' )
    lea         eax, [edi+ecx-1]                ;
    jmp         _strchr_1_loc_2                 ; return &str[ strlen( str ) + 1 ]
_strchr_1_loc_1:
    sub         edi, ecx                        ; char const* str
    mov         eax, ebx                        ; int ch
    repne scasb                                 ; search for ch
    xor         eax, eax                        ;
    test        ecx, ecx                        ;
    jz          _strchr_1_loc_2                 ; if ( !found ) return 0
    lea         eax, [edi-1]                    ; return &str[ found ]
_strchr_1_loc_2:
    pop         ebx
    pop         edi
    ret
_strchr_1 endp

end

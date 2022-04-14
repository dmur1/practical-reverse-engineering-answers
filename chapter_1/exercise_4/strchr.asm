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
    jz          _strchr_1_loc_1                 ; if ( ch != '\0' )
    sub         edi, ecx                        ; char const* str
    mov         eax, ebx                        ; int ch
    repne scasb                                 ; search for ch
    xor         eax, eax
    sub         edi, 1                          ; &str[ found ]
    test        ecx, ecx                        ;
    cmovnz      eax, edi                        ; return found ? &str[ found ] : 0
    pop         ebx
    pop         edi
    ret
_strchr_1_loc_1:
    lea         eax, [edi+ecx-1]                ; return ch == \'0' ? &str[ strlen( str ) ] : ...
    pop         ebx
    pop         edi
    ret
_strchr_1 endp

; char* strchr_2( char const* str, int ch )
; using cmp
_strchr_2 proc
    push        edi
    xor         ecx, ecx
    mov         eax, [esp+8]                    ; char const* str
    mov         edx, [esp+12]                   ; int ch
_strchr_2_loc_1:
    cmp         byte ptr [eax+ecx], 0           ; while ( *s++ != '\0' )
    lea         ecx, [ecx+1]
    jne         _strchr_2_loc_1
_strchr_2_loc_2:
    movsx       edi, byte ptr [eax]             ; for ( int i = 0; i < strlen( str ) + 1; ++i )
    cmp         edi, edx                        ; if ( str[ i ] == ch )
    je          _strchr_2_loc_3
    inc         eax
    dec         ecx
    jne         _strchr_2_loc_2
    xor         eax, eax
    pop         edi
    ret                                         ; return 0
_strchr_2_loc_3:
    pop         edi
    ret                                         ; return &str[ found ]
_strchr_2 endp

end

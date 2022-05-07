.model flat
.code

; extern "C" int strcmp_1( char const* s1, char const* s2 )
; based on https://github.com/torvalds/linux/blob/master/arch/x86/lib/string_32.c#L96
_strcmp_1 proc
    push    esi
    push    edi
    mov     esi, dword ptr [esp+12] ; char const* s1
    mov     edi, dword ptr [esp+16] ; char const* s2
_strcmp_1_loc_1:
    lodsb                           ; c1 = *s1++
    scasb                           ; c2 = *s2++
    jne     _strcmp_1_loc_2         ; if ( c1 != c2 )
    test    al, al
    jne     _strcmp_1_loc_1         ; if ( al != '\0' )
    xor     eax, eax
    jmp     _strcmp_1_loc_3         ; if ( c1 == c2 ) { return 0; }
_strcmp_1_loc_2:
    sbb     eax, eax                ; if ( ( c1 - c2 ) < 0 ) { eax = -1; } else { eax = 0; }
    or      al, 1                   ; if ( c1 < c2 ) { return -1; } else { return 1; }
_strcmp_1_loc_3:
    pop     edi
    pop     esi
    ret
_strcmp_1 endp

end

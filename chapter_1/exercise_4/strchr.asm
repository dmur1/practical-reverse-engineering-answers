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

; char* strchr_3( char const* str, int ch )
; check 4 bytes - inspired by https://www.agner.org/optimize/optimizing_assembly.pdf
_strchr_3 proc
    push        ebx
    push        edi
    push        esi
    mov         ecx, [esp+16]
    mov         edi, [esp+20]
    imul        edi, edi, 01010101h
    mov         eax, ecx
    and         ecx, 3
    jz          _strchr_3_loc_3
_strchr_3_loc_1:
    and         eax, -4
    mov         ebx, [eax]
    shl         ecx, 3
    mov         edx, -1
    shl         edx, cl
    not         edx
    or          ebx, edx
    mov         esi, ebx
    xor         esi, edi
    lea         ecx, [esi-01010101h]
    not         esi
    and         esi, ecx
    and         esi, 80808080h
    lea         ecx, [ebx-01010101h]
    not         ebx
    and         ecx, ebx
    and         ecx, 80808080h
    test        esi, esi
    jnz         _strchr_3_loc_4
    test        ecx, ecx
    jnz         _strchr_3_loc_4
_strchr_3_loc_2:
    add         eax, 4
_strchr_3_loc_3:
    mov         ebx, [eax]
    mov         esi, ebx
    xor         esi, edi
    lea         ecx, [esi-01010101h]
    not         esi
    and         esi, ecx
    and         esi, 80808080h
    lea         ecx, [ebx-01010101h]
    not         ebx
    and         ecx, ebx
    and         ecx, 80808080h
    test        ecx, ecx
    jnz         _strchr_3_loc_4
    test        esi, esi
    jz          _strchr_3_loc_2
_strchr_3_loc_4:
    bsf         esi, esi
    bsf         ecx, ecx
    cmp         esi, ecx
    jb          _strchr_3_loc_5
    shr         esi, 3
    add         eax, esi
    pop         esi
    pop         edi
    pop         ebx
    ret
_strchr_3_loc_5:
    xor         eax, eax
    pop         esi
    pop         edi
    pop         ebx
    ret
_strchr_3 endp

; char* strchr_4( char const* str, int ch )
; check 16 bytes - inspired by https://www.agner.org/optimize/optimizing_assembly.pdf
_strchr_4 proc
    push        ebx
    push        edi
    mov         eax, [esp+12]       ; char const* str
    mov         edi, [esp+16]       ; int ch
    imul        edi, edi, 01010101h
    movd        xmm1, edi
    pshufd      xmm1, xmm1, 0
    pxor        xmm0, xmm0
    mov         ecx, eax
    and         ecx, 15
    and         eax, -16
    movdqa      xmm2, [eax]
    movdqa      xmm3, xmm2
    pcmpeqb     xmm2, xmm0          ; test for zero
    pcmpeqb     xmm3, xmm1          ; test for ch
    pmovmskb    edx, xmm2
    pmovmskb    ebx, xmm3
    shr         edx, cl
    shl         edx, cl             ; shift invalid bits out of edx
    shr         ebx, cl
    shl         ebx, cl             ; shift invalid bits out of ebx
    bsf         edx, edx
    jnz         _strchr_4_loc_3     ; jump if found a zero
    bsf         ebx, ebx
    jnz         _strchr_4_loc_2     ; jump if found ch
_strchr_4_loc_1:
    add         eax, 16
    movdqa      xmm2, [eax]
    movdqa      xmm3, xmm2
    pcmpeqb     xmm2, xmm0          ; test for zero
    pcmpeqb     xmm3, xmm1          ; test for ch
    pmovmskb    edx, xmm2
    pmovmskb    ebx, xmm3
    bsf         edx, edx
    jnz         _strchr_4_loc_3     ; found a zero
    bsf         ebx, ebx
    jz          _strchr_4_loc_1     ; didn't find ch
_strchr_4_loc_2:
    add         eax, ebx
    pop         edi
    pop         ebx
    ret
_strchr_4_loc_3:
    bsf         ebx, ebx
    jz          _strchr_4_loc_4
    cmp         edx, ebx
    jae         _strchr_4_loc_2
_strchr_4_loc_4:
    xor         eax, eax
    pop         edi
    pop         ebx
    ret
_strchr_4 endp

end

.model flat
.code

; size_t strlen_1( char const* str )
; using repne scasb
_strlen_1 proc
    push    edi
    mov     edi, dword ptr [esp+8]
    xor     eax, eax
    xor     ecx, ecx
    not     ecx
    cld
    repne scasb
    not     ecx
    sub     ecx, 1
    mov     eax, ecx
    pop     edi
    ret
_strlen_1 endp

; size_t strlen_2( char const* str )
; using cmp jne
_strlen_2 proc
    mov     edx, [esp+4]
    mov     eax, -1
@@:
    inc     eax
    cmp     byte ptr [eax+edx], 0
    jne     @B
    ret
_strlen_2 endp

; size_t strlen_3( char const* str )
; check 4 bytes source https://www.agner.org/optimize/optimizing_assembly.pdf
_strlen_3 proc
    push    ebx
    mov     ecx, [esp+8]
    mov     eax, ecx
    and     ecx, 3
    jz      _strlen_3_loc_2
    and     eax, -4
    mov     ebx, [eax]
    shl     ecx, 3
    mov     edx, -1
    shl     edx, cl
    not     edx
    or      ebx, edx
    lea     ecx, [ebx-01010101h]
    not     ebx
    and     ecx, ebx
    and     ecx, 80808080h
    jnz     _strlen_3_loc_3
_strlen_3_loc_1:
    add     eax, 4
_strlen_3_loc_2:
    mov     ebx, [eax]
    lea     ecx, [ebx-01010101h]
    not     ebx
    and     ecx, ebx
    and     ecx, 80808080h
    jz      _strlen_3_loc_1
_strlen_3_loc_3:
    bsf     ecx, ecx
    shr     ecx, 3
    sub     eax, [esp+8]
    add     eax, ecx
    pop     ebx
    ret
_strlen_3 endp

; size_t strlen_4( char const* str )
; check 4 bytes with sse2 source https://www.agner.org/optimize/optimizing_assembly.pdf
_strlen_4 proc
    mov         eax, [esp+4]
    mov         ecx, eax
    pxor        xmm0, xmm0
    and         ecx, 15
    and         eax, -16
    movdqa      xmm1, [eax]
    pcmpeqb     xmm1, xmm0
    pmovmskb    edx, xmm1
    shr         edx, cl
    shl         edx, cl
    bsf         edx, edx
    jnz         _strlen_4_loc_2
_strlen_4_loc_1:
    add         eax, 16
    movdqa      xmm1, [eax]
    pcmpeqb     xmm1, xmm0
    pmovmskb    edx, xmm1
    bsf         edx, edx
    jz          _strlen_4_loc_1
_strlen_4_loc_2:
    sub         eax, [esp+4]
    add         eax, edx
    ret
_strlen_4 endp

end

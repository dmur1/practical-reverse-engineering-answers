.model flat
.code

; size_t strlen_1( char const* str );
; using repne scasb with a stack frame
_strlen_1 proc
    push    ebp
    mov     ebp, esp
    push    edi
    mov     edi, dword ptr [ebp+8]
    xor     eax, eax
    xor     ecx, ecx
    not     ecx
    cld
    repne scasb
    not     ecx
    sub     ecx, 1
    mov     eax, ecx
    pop     edi
    mov     ebp, esp
    pop     ebp
    ret
_strlen_1 endp

; size_t strlen_2( char const* str )
; using repne scasb without a stack frame
_strlen_2 proc
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
_strlen_2 endp

; size_t strlen_3( char const* str )
; using cmp jne with a stack frame
_strlen_3 proc
    push    ebp
    mov     ebp, esp
    mov     edx, [ebp+8]
    mov     eax, -1
@@:
    inc     eax
    cmp     byte ptr [eax+edx], 0
    jne     @B
    mov     esp, ebp
    pop     ebp
    ret
_strlen_3 endp

; size_t strlen_4( char const* str )
; using cmp jne without a stack frame
_strlen_4 proc
    mov     edx, [esp+4]
    mov     eax, -1
@@:
    inc     eax
    cmp     byte ptr [eax+edx], 0
    jne     @B
    ret
_strlen_4 endp


end

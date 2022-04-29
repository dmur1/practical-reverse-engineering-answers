.model flat
.code

; extern "C" void* _memcpy_1( void* dst, void* src, size_t n )
; using repne movsb
_memcpy_1 proc
    push    edi
    push    esi
    mov     ecx, dword ptr [esp+20] ; size_t n
    mov     esi, dword ptr [esp+16] ; void* src
    mov     edi, dword ptr [esp+12] ; void* dst
    rep     movsb
    mov     eax, dword ptr [esp+12] ; return dst
    pop     esi
    pop     edi
    ret
_memcpy_1 endp

; extern "C" void* _memcpy_2( void* dst, void* src, size_t n )
; using cmp jnz
_memcpy_2 proc
    push    edi
    push    esi
    mov     edx, dword ptr [esp+20] ; size_t n
    mov     esi, dword ptr [esp+16] ; void* src
    mov     edi, dword ptr [esp+12] ; void* dst
    test    edx, edx
    jz      _memcpy_2_loc_2
    xor     ecx, ecx
_memcpy_2_loc_1:
    movzx   eax, byte ptr [esi+ecx]
    mov     byte ptr [edi+ecx], al
    inc     ecx
    cmp     edx, ecx
    jnz     _memcpy_2_loc_1
_memcpy_2_loc_2:
    mov     eax, dword ptr [esp+12] ; return dst
    pop     esi
    pop     edi
    ret
_memcpy_2 endp

end

.model flat
.code

; extern "C" void* _memcpy_1( void* dst, void* src, size_t n )
; using rep movsb without a zero test on size
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
; using rep movsb with a zero test on size
_memcpy_2 proc
    push    edi
    push    esi
    mov     ecx, dword ptr [esp+20] ; size_t n
    test    ecx, ecx
    jz      _memcpy_2_loc_1
    mov     esi, dword ptr [esp+16] ; void* src
    mov     edi, dword ptr [esp+12] ; void* dst
    rep     movsb
_memcpy_2_loc_1:
    mov     eax, dword ptr [esp+12] ; return dst
    pop     esi
    pop     edi
    ret
_memcpy_2 endp

; extern "C" void* _memcpy_3( void* dst, void* src, size_t n )
; using rep movsd followed by rep movsb without zero tests
_memcpy_3 proc
    push    edi
    push    esi
    mov     ecx, dword ptr [esp+20] ; size_t n
    mov     esi, dword ptr [esp+16] ; void* src
    mov     edi, dword ptr [esp+12] ; void* dst
    mov     edx, ecx
    shr     ecx, 2
    and     edx, 3
    rep     movsd
    mov     ecx, edx
    rep     movsb
    mov     eax, dword ptr [esp+12] ; return dst
    pop     esi
    pop     edi
    ret
_memcpy_3 endp

; extern "C" void* _memcpy_4( void* dst, void* src, size_t n )
; using rep movsd followed by rep movsb
_memcpy_4 proc
    push    edi
    push    esi
    mov     ecx, dword ptr [esp+20] ; size_t n
    mov     esi, dword ptr [esp+16] ; void* src
    mov     edi, dword ptr [esp+12] ; void* dst
    mov     edx, ecx
    shr     ecx, 2
    and     edx, 3
    test    ecx, ecx
    jz      _memcpy_4_loc_1
    rep     movsd
_memcpy_4_loc_1:
    test    edx, edx
    jz      _memcpy_4_loc_2
    mov     ecx, edx
    rep     movsb
_memcpy_4_loc_2:
    mov     eax, dword ptr [esp+12] ; return dst
    pop     esi
    pop     edi
    ret
_memcpy_4 endp

; extern "C" void* _memcpy_5( void* dst, void* src, size_t n )
; using cmp jnz
_memcpy_5 proc
    push    edi
    push    esi
    mov     edx, dword ptr [esp+20] ; size_t n
    test    edx, edx
    jz      _memcpy_5_loc_2
    mov     esi, dword ptr [esp+16] ; void* src
    mov     edi, dword ptr [esp+12] ; void* dst
    xor     ecx, ecx
_memcpy_5_loc_1:
    movzx   eax, byte ptr [esi+ecx]
    mov     byte ptr [edi+ecx], al
    add     ecx, 1
    cmp     edx, ecx
    jnz     _memcpy_5_loc_1
_memcpy_5_loc_2:
    mov     eax, dword ptr [esp+12] ; return dst
    pop     esi
    pop     edi
    ret
_memcpy_5 endp

end

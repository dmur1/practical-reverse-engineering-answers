.model flat
.code

; extern "C" void* memset_1( void* s, int c, size_t n )
; using rep stosb without a zero test on size
_memset_1 proc
    push    edi
    mov     ecx, dword ptr [esp+16] ; size_t n
    mov     eax, dword ptr [esp+12] ; int c
    mov     edi, dword ptr [esp+8]  ; void* s
    rep     stosb
    mov     eax, dword ptr [esp+8]  ; return s
    pop     edi
    ret
_memset_1 endp

; extern "C" void* memset_2( void* s, int c, size_t n )
; using rep stosb with a zero test on size
_memset_2 proc
    push    edi
    mov     ecx, dword ptr [esp+16] ; size_t n
    test    ecx, ecx
    jz      _memset_2_loc_1
    mov     eax, dword ptr [esp+12] ; int c
    mov     edi, dword ptr [esp+8]  ; void* s
    rep     stosb
_memset_2_loc_1:
    mov     eax, dword ptr [esp+8]  ; return s
    pop     edi
    ret
_memset_2 endp

; extern "C" void* memset_3( void* s, int c, size_t n )
; using rep stosd followed by rep stosb without a zero test on size
; imul eax, eax, 01010101h distributes the low byte throughout eax
_memset_3 proc
    push    edi
    mov     ecx, dword ptr [esp+16] ; size_t n
    movzx   eax, byte ptr [esp+12]  ; int c
    mov     edi, dword ptr [esp+8]  ; void* s
    imul    eax, eax, 01010101h
    mov     edx, ecx
    shr     ecx, 2
    and     edx, 3
    rep     stosd
    mov     ecx, edx
    rep     stosb
    mov     eax, dword ptr [esp+8]  ; return s
    pop     edi
    ret
_memset_3 endp

; extern "C" void* memset_4( void* s, int c, size_t n )
; using rep stosd followed by rep stosb with zero tests on size
; imul eax, eax, 01010101h distributes the low byte throughout eax
_memset_4 proc
    push    edi
    mov     ecx, dword ptr [esp+16] ; size_t n
    movzx   eax, byte ptr [esp+12]  ; int c
    mov     edi, dword ptr [esp+8]  ; void* s
    mov     edx, ecx
    shr     ecx, 2
    and     edx, 3
    test    ecx, ecx
    jz      _memset_4_loc_1
    imul    eax, eax, 01010101h
    rep     stosd
_memset_4_loc_1:
    mov     ecx, edx
    test    ecx, ecx
    jz      _memset_4_loc_2
    rep     stosb
_memset_4_loc_2:
    mov     eax, dword ptr [esp+8]  ; return s
    pop     edi
    ret
_memset_4 endp

end

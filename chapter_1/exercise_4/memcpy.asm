.model flat
.code

;
; from the intel optimization guide
;
; Cache eviction — If the amount of data to be processed by a memory routine
; approaches half the size of the last level on-die cache, temporal locality
; of the cache may suffer. Using streaming store instructions (for example:
; MOVNTQ, MOVNTDQ) can minimize the effect of flushing the cache. The threshold
; to start using a streaming store depends on the size of the last level cache.
; Determine the size using the deterministic cache parameter leaf of CPUID.
;
; 3.7.6 Enhanced REP MOVSB and STOSB Operation
; Beginning with processors based on Ivy Bridge microarchitecture, REP string
; operation using MOVSB and STOSB can provide both flexible and high-performance
; REP string operations for software in common situations like memory copy and
; set operations. Processors that provide enhanced MOVSB/STOSB operations are
; enumerated by the CPUID feature flag: CPUID:(EAX=7H, ECX=0H):EBX.[bit 9] = 1.
;
; 3.7.6.1 Fast Short REP MOVSB
; Beginning with processors based on Ice Lake Client microarchitecture, REP MOVSB
; performance of short operations is enhanced. The enhancement applies to string
; lengths between 1 and 128 bytes long. Support for fast-short REP MOVSB is enumerated
; by the CPUID feature flag: CPUID [EAX=7H,ECX=0H).EDX.FAST_SHORT_REP_MOVSB[bit 4] = 1.
; There is no change in the REP STOS performance.
;
; For processors supporting enhanced REP MOVSB/STOSB, implementing memcpy with
; REP MOVSB will provide even more compact benefits in code size and better throughput
; than using the combination of REP MOVSD+B. For processors based on Ivy Bridge microarchitecture,
; implementing memcpy using Enhanced REP MOVSB and STOSB might not reach the same level
; of throughput as using 256-bit or 128-bit AVX alternatives, depending on length and alignment factors.
;
; C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.31.31103\crt\src\i386\memcpy.asm
;

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

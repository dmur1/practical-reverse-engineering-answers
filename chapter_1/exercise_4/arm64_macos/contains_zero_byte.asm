    .text
    .p2align 2

// extern "C" int contains_zero_byte_( int x )
    .global _contains_zero_byte_
_contains_zero_byte_:
    mov     w0,0
    ret

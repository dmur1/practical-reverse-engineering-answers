.model flat
.code

_contains_zero_byte_ proc
    mov     eax, [esp+4]
    lea     ecx, [eax-01010101h]
    not     eax
    and     eax, 80808080h
    and     eax, ecx
    ret
_contains_zero_byte_ endp

end

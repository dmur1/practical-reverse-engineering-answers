.model flat
.code

_contains_zero_byte_ proc
    push    ebx
    xor     eax, eax
    mov     ebx, [esp+8]
    lea     ecx, [ebx-01010101h]
    not     ebx
    and     ecx, ebx
    and     ecx, 80808080h
    setnz   al
    pop     ebx
    ret
_contains_zero_byte_ endp

end

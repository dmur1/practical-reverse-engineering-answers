Microsoft (R) COFF/PE Dumper Version 14.31.31104.0
Copyright (C) Microsoft Corporation.  All rights reserved.


Dump of file decompiled.obj

File Type: COFF OBJECT

_DllMain@12:
  00000000: 55                 push        ebp
  00000001: 8B EC              mov         ebp,esp
  00000003: 81 EC 30 01 00 00  sub         esp,130h
  00000009: 0F 01 4D F8        sidt        fword ptr [ebp-8]
  0000000D: 8B 45 FA           mov         eax,dword ptr [ebp-6]
  00000010: 05 FF 0B FC 7F     add         eax,7FFC0BFFh
  00000015: 56                 push        esi
  00000016: 3D FF 7F 00 00     cmp         eax,7FFFh
  0000001B: 0F 87 B0 00 00 00  ja          000000D1
  00000021: 57                 push        edi
  00000022: 33 C0              xor         eax,eax
  00000024: C7 85 D0 FE FF FF  mov         dword ptr [ebp-130h],0
            00 00 00 00
  0000002E: 50                 push        eax
  0000002F: B9 49 00 00 00     mov         ecx,49h
  00000034: 8D BD D4 FE FF FF  lea         edi,[ebp-12Ch]
  0000003A: F3 AB              rep stos    dword ptr es:[edi]
  0000003C: 6A 02              push        2
  0000003E: E8 00 00 00 00     call        _CreateToolhelp32Snapshot@8
  00000043: 8B F0              mov         esi,eax
  00000045: 5F                 pop         edi
  00000046: 83 FE FF           cmp         esi,0FFFFFFFFh
  00000049: 0F 84 82 00 00 00  je          000000D1
  0000004F: 8D 85 D0 FE FF FF  lea         eax,[ebp-130h]
  00000055: C7 85 D0 FE FF FF  mov         dword ptr [ebp-130h],128h
            28 01 00 00
  0000005F: 50                 push        eax
  00000060: 56                 push        esi
  00000061: E8 00 00 00 00     call        _Process32First@8
  00000066: 85 C0              test        eax,eax
  00000068: 74 40              je          000000AA
  0000006A: 66 0F 1F 44 00 00  nop         word ptr [eax+eax]
  00000070: 8D 85 F4 FE FF FF  lea         eax,[ebp-10Ch]
  00000076: 50                 push        eax
  00000077: FF 35 00 00 00 00  push        dword ptr [?process_name@@3PBDB]
  0000007D: E8 00 00 00 00     call        __stricmp
  00000082: 83 C4 08           add         esp,8
  00000085: 85 C0              test        eax,eax
  00000087: 74 13              je          0000009C
  00000089: 8D 85 D0 FE FF FF  lea         eax,[ebp-130h]
  0000008F: 50                 push        eax
  00000090: 56                 push        esi
  00000091: E8 00 00 00 00     call        _Process32Next@8
  00000096: 85 C0              test        eax,eax
  00000098: 75 D6              jne         00000070
  0000009A: EB 0E              jmp         000000AA
  0000009C: 8B 85 E8 FE FF FF  mov         eax,dword ptr [ebp-118h]
  000000A2: 3B 85 D8 FE FF FF  cmp         eax,dword ptr [ebp-128h]
  000000A8: 75 27              jne         000000D1
  000000AA: 83 7D 0C 01        cmp         dword ptr [ebp+0Ch],1
  000000AE: 75 15              jne         000000C5
  000000B0: 6A 00              push        0
  000000B2: 6A 00              push        0
  000000B4: 68 D0 32 00 10     push        100032D0h
  000000B9: 6A 00              push        0
  000000BB: 6A 00              push        0
  000000BD: 6A 00              push        0
  000000BF: FF 15 00 00 00 00  call        dword ptr [__imp__CreateThread@24]
  000000C5: B8 01 00 00 00     mov         eax,1
  000000CA: 5E                 pop         esi
  000000CB: 8B E5              mov         esp,ebp
  000000CD: 5D                 pop         ebp
  000000CE: C2 0C 00           ret         0Ch
  000000D1: 33 C0              xor         eax,eax
  000000D3: 5E                 pop         esi
  000000D4: 8B E5              mov         esp,ebp
  000000D6: 5D                 pop         ebp
  000000D7: C2 0C 00           ret         0Ch

  Summary

          40 .chks64
           4 .data
        8440 .debug$S
          70 .debug$T
          5D .drectve
           D .rdata
          DA .text$mn

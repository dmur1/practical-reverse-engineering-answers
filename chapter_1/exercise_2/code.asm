Microsoft (R) COFF/PE Dumper Version 14.31.31104.0
Copyright (C) Microsoft Corporation.  All rights reserved.


Dump of file decompiled.obj

File Type: COFF OBJECT

_DllMain@12:
  00000000: 55                 push        ebp
  00000001: 8B EC              mov         ebp,esp
  00000003: 81 EC 30 01 00 00  sub         esp,130h
  00000009: 0F 01 4D F8        sidt        fword ptr [ebp-8]
  0000000D: 8B 45 FC           mov         eax,dword ptr [ebp-4]
  00000010: 05 FF 0B FC 7F     add         eax,7FFC0BFFh
  00000015: 56                 push        esi
  00000016: 3D FF 7F 00 00     cmp         eax,7FFFh
  0000001B: 77 6D              ja          0000008A
  0000001D: 57                 push        edi
  0000001E: 33 C0              xor         eax,eax
  00000020: C7 85 D0 FE FF FF  mov         dword ptr [ebp-130h],0
            00 00 00 00
  0000002A: 50                 push        eax
  0000002B: B9 49 00 00 00     mov         ecx,49h
  00000030: 8D BD D4 FE FF FF  lea         edi,[ebp-12Ch]
  00000036: F3 AB              rep stos    dword ptr es:[edi]
  00000038: 6A 02              push        2
  0000003A: E8 00 00 00 00     call        _CreateToolhelp32Snapshot@8
  0000003F: 8B F0              mov         esi,eax
  00000041: 5F                 pop         edi
  00000042: 83 FE FF           cmp         esi,0FFFFFFFFh
  00000045: 74 43              je          0000008A
  00000047: 8D 85 D0 FE FF FF  lea         eax,[ebp-130h]
  0000004D: 50                 push        eax
  0000004E: 56                 push        esi
  0000004F: E8 00 00 00 00     call        _Process32First@8
  00000054: 85 C0              test        eax,eax
  00000056: 74 32              je          0000008A
  00000058: 0F 1F 84 00 00 00  nop         dword ptr [eax+eax]
            00 00
  00000060: 8D 85 F4 FE FF FF  lea         eax,[ebp-10Ch]
  00000066: 50                 push        eax
  00000067: FF 35 00 00 00 00  push        dword ptr [?process_name@@3PBDB]
  0000006D: E8 00 00 00 00     call        __stricmp
  00000072: 83 C4 08           add         esp,8
  00000075: 85 C0              test        eax,eax
  00000077: 74 1A              je          00000093
  00000079: 8D 85 D0 FE FF FF  lea         eax,[ebp-130h]
  0000007F: 50                 push        eax
  00000080: 56                 push        esi
  00000081: E8 00 00 00 00     call        _Process32Next@8
  00000086: 85 C0              test        eax,eax
  00000088: 75 D6              jne         00000060
  0000008A: 33 C0              xor         eax,eax
  0000008C: 5E                 pop         esi
  0000008D: 8B E5              mov         esp,ebp
  0000008F: 5D                 pop         ebp
  00000090: C2 0C 00           ret         0Ch
  00000093: 83 7D 0C 01        cmp         dword ptr [ebp+0Ch],1
  00000097: 74 15              je          000000AE
  00000099: 6A 00              push        0
  0000009B: 6A 00              push        0
  0000009D: 6A 00              push        0
  0000009F: 68 D0 32 00 10     push        100032D0h
  000000A4: 6A 00              push        0
  000000A6: 6A 00              push        0
  000000A8: FF 15 00 00 00 00  call        dword ptr [__imp__CreateThread@24]
  000000AE: B8 01 00 00 00     mov         eax,1
  000000B3: 5E                 pop         esi
  000000B4: 8B E5              mov         esp,ebp
  000000B6: 5D                 pop         ebp
  000000B7: C2 0C 00           ret         0Ch

  Summary

          30 .chks64
           4 .data
          A8 .debug$S
          5D .drectve
           D .rdata
          BA .text$mn

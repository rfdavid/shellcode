BITS 32

jmp short       __end             ; Pula para o final

__start:
 pop             ecx             ; ECX = Endereco da string finger$
 xor             eax, eax        ; EAX = 0
 mov byte        [ecx + 6], 0xa  ; Caracter '$' sera \n
 
;  write (1, "finger\n", 7);
 mov byte        al, 0x4         ; AL = 4 (syscall write)
 xor             ebx, ebx        ; ebx = 0
 inc             ebx             ; ebx = 1 (stdout)
 xor             edx, edx        ; edx = 0
 mov byte        dl, 0x7         ; dl = 7 (tamanho da string)
 int             0x80

; exit (0); 
 xor             eax, eax       ; eax = 0
 inc             eax            ; eax = 1
 xor             ebx, ebx       ; ebx = 0
 int             0x80           ; exit (0);

__end:
call            __start

db              'finger$'

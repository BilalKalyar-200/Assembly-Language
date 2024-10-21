[org 0x100]

mov ax, 5       ;find cube of 5
mov bx, ax     
mul ax         ; ax = ax * ax

mul bx         ; ax = ax * bx

mov ax, 0x4c00 
int 0x21       

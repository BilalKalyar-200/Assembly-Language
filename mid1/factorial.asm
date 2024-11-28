[org 0x100]
mov ax,5
mov bx,5
fact:
mul bx	;ax=ax*bx ;ax=1*4
sub bx,1
jnz fact

mov ax,0x4c00
int 0x21
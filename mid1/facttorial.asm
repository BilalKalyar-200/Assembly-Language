[org 0x100]
mov ax,1
mov cx,5

fact:
mul cx  ;ax=ax*cx   ax=1*5    ax=5*4    ax=20*3  
loop cx

mov ax,0x4c00
int 0x21

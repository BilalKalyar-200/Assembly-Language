[org 0x100]
mov ax,1
mov cx,5
l1:
mul cx
loop l1


mov ax,0x4c00
int 0x21

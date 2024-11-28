[org 0x100]
mov  al , [num]
mov bx,5
l1:
mul bx
sub bx,1
cmp bx,0
jne l1




mov ax,0x4c00
int 0x21
num: db 4,3,2,4,1

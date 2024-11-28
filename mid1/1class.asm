[org 0x100]


mov ax,[num]
mov bx,0
mov cx,0
l1:


add bx,2
cmp bx,20
je end

cmp [num+bx],ax
ja l2

jmp l1

l2:
mov ax,[num+bx]
mov cx,ax
jmp l1

end:
mov ax,0x4c00
int 0x21

num: dw 1,2,3,4,5,6,7,10,9,1
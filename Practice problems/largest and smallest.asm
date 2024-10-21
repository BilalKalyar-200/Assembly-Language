[org 0x100]

mov ax,0
mov bx,0
mov cx,0	;conatianing largest
mov dx,[num]	;containing smallest
l1:

mov ax,[num+bx]      ;find largest
add bx,2
cmp bx,20
jne l2
jmp end

l2:
cmp ax,cx
ja swap

cmp ax,dx
jb swap_small

jmp l1
swap:
mov cx,ax
jmp l1

swap_small:
mov dx,ax
jmp l1

end:
mov ax,0x4c00
int 0x21

num: dw 0,1,2,3,10,5,4,8,2,9
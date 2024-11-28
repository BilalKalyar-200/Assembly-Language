[org 0x100]
mov bx,0

l1:
mov al,[num+bx]
add bx,1
cmp bx,9
ja sort

cmp al,0
jl swap
jmp l1

swap:
mov byte [num+bx-1],100
jmp l1

sort:
mov bx,0
mov byte[swaper],0

l2:
mov al,[num+bx]
cmp al,[num+bx+1]
jae no_swap

mov dl,[num+bx+1]
mov [num+bx+1],al
mov [num+bx],dl
mov byte [swaper],1

no_swap:
add bx,1
cmp bx,8
jne l2
cmp byte[swaper],1
je sort
mov ax,0x4c00
int 0x21

num: db -1,0,1,-1,0,-1,1,1,-1
swaper: db 0
;working-->> searches for negative numebr and if that negative number is greater than -30 than swap array 1 with array2 otherwise sort array 1

[org 0x100]
mov bx,0

l1:
mov ax,[num+bx]
add bx,2
cmp bx,20
je sort
cmp ax,0
jl find

jmp l1


find:
cmp ax,-30
jg swap
jmp l1

swap:
mov bx,0
swap_start:

mov ax,[num+bx]
mov dx,[num2+bx]
mov [num+bx],dx
mov [num2+bx],ax
add bx,2
cmp bx,18
jne swap_start
jmp end

sort:
mov bx,0
mov byte[swaper],0
l3:
mov ax,[num+bx]
cmp ax,[num+bx+2]
jbe no_swap

mov dx,[num+bx+2]
mov [num+bx+2],ax
mov [num+bx],dx
mov byte[swaper],1

no_swap:
add bx,2
cmp bx,18
jne l3
cmp byte[swaper],1
je sort

end:
mov ax,0x4c00
int 0x21

num: dw 1,2,4,5,3,-20,4,12,4,20
num2: dw 1,1,1,1,1,1,1,1,1,1
swaper: db 0

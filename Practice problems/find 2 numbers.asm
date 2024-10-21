[org 0x100]

mov ax,0
mov bx,0

l1:
mov ax,[num+bx]
add bx,2
cmp bx,20
je end

l2:
cmp ax,0
je zero_found

l3:
cmp ax,20
je twenty_found

jmp l1

zero_found:
mov cx,1
mov [num2],cx
jmp l1

twenty_found:
mov cx,1
mov [num3],cx
jmp l1

end:
mov ax,0x4c00
int 0x21

num: dw 1,2,0,4,20,6,7,8,9,10
num2: dw 0 
num3: dw 0
;This program first multiplies two numbers that are 17 and 6
;It loads both from memory and then multiplies them and
;stores the result in another memory location


mov ax,[num] 
mov bx,[p] ; loads multiplier

mov cx,16
mov di,0

l1:
shr bx, 1 ; shifting multiplier
jnc skip
add di, ax

skip:
shl ax, 1 ; shifting multiplicand
loop l1

mov [result], di

mov ax, 0x4c00
int 0x21

num: dw 17
p: dw 6
result: dd 0

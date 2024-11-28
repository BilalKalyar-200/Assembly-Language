[org 0x100]
jmp start


swap:
push ax
xchg ax,[bx+si+2]
mov [bx+si],ax
pop ax
ret

bubblesort:
push bp
mov bp,sp

push ax
push bx
push cx
push si

mov bx,[bp+6]
mov cx,[bp+4]
sub cx,1
shl cx,1
l1:

mov byte [swaper],0
mov si,0
l2:
mov ax,[bx+si]
cmp ax,[bx+si+2]
jle noswap
call swap
mov byte[swaper],1

noswap:
add si,2
cmp si,cx
jne l2
cmp byte[swaper],1
je l1

pop si
pop cx
pop bx
pop ax
pop bp
ret 4
start:

;mov ax,num
;push ax
;mov ax,10
;push ax
;call bubblesort

mov ax,num
push ax
mov ax,num2
push ax
mov ax,10
push ax
call multiply

mov ax,0x4c00
int 0x21

num: dw 4,3,2,5,6,7,8,9,2,3
num2: dw 3,5,6,2,4,7,8,9,2,1
swaper: db 0
result: dw 0
multiply:
push bp
mov bp,sp
mov bx,[bp+8]    ;first array
mov si,[bp+6]   ;second array
mov ax,[bx]     ;multiplicand
mov dx,[si]     ;multiplier
mov cx,16

l3:
shr dx,1
jnc skip
add [result],ax
skip:
shl ax,1
dec cx
cmp cx,0
ja l3

pop bp
return
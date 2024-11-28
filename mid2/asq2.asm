[org 0x100]
jmp start
count_bits:
push ax
push cx
push dx
push di
mov dx,0    ;number of ones
mov cx,16   ;number of bits
mov di,0    ;number of zeros
l2:
shr ax,1
jnc zero
add dx,1
jmp check

zero:
add di,1

check:
dec cx
cmp cx,0
jne l2
mov [count_hold],di ;storing number of 0
mov [count_hold+2],dx ;storing number of 1
pop di
pop dx
pop cx
pop ax
ret

process_word:
push bp
mov bp,sp
push ax
push bx
push cx
push dx
push si


mov bx,[bp+6]   ;address of array
mov cx,[bp+4]   ;no of elements
sub cx,1
shl cx,1
mov si,0
l1:
mov dx,0
mov ax,[bx+si]
cmp ax,0
je skip

call count_bits

shr ax,1    ;perform bitwise operation
jnc even
jmp odd

even:
mov ax,[count_hold]     ;getting data for this number
mov [bx+si],ax  ;replacing with number of zeros
jmp skip
odd:
mov ax,[count_hold+2]   ;getting data for this number
mov [bx+si],ax  ;replacing with number of ones


skip:
add si,2
cmp si,cx
jne l1

pop si
pop dx
pop cx
pop bx
pop ax
pop bp
ret 4

start:
mov ax,num
push ax
mov ax,6    ;number of elements
push ax
call process_word


end:
mov ax,0x4c00
int 0x21
num: dw 1,2,3,4,5,0
count_hold: dw 0,0
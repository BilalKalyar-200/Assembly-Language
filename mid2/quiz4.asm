[org 0x0100]

jmp start

mull2:
push bp
mov bp,sp
mov bx,[bp+6]
mov cx,[bp+4]
dec cx
shl cx,1
mov ax,[bx]
mov si,cx
mov dx,[bx+si]
mov si,16
checkbit:
shr dx,1
jnc skip3
add[arrnew],ax

skip3:
shl ax,1
dec si
cmp si,0
jnz checkbit
pop bp
ret




swap:
push ax
mov ax,[bx+si]
xchg ax,[bx+si+2]
mov [bx+si],ax
pop ax
ret

bubblesort: push bp
mov bp,sp
push ax
push cx
push si
mov cx,[bp+4]
mov bx,[bp+6]
dec cx
shl cx,1
L1:
mov si,0
mov byte [swaper],0
L2:
mov ax,[bx+si]
cmp ax,[bx+si+2]
jae skip
call swap
mov byte[swaper],1

    skip:
    add si,2
    cmp si,cx
    jne L2
    cmp byte [swaper],1
    je L1
    pop si
    pop cx
 pop ax
 pop bp
 ret 4

start:
mov ax, 7FFFh
add ax, 1

mov di,arr
mov dx,4
mov bx,1
mov cx,[bitcheck]
ror bx,6
test bx,cx
jz sort1
jmp multiply

sort1:
push di
push dx
call bubblesort
jmp end

multiply:
push di
push dx
call mull2
jmp end
end:
mov ax,0x4c00
int 0x21

arr: dw 19,29,25,4
arrnew: dd 0
bitcheck: dw 216
swaper: db 0
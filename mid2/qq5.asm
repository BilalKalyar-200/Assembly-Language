[org 0x100]
jmp start
print:
    push bp
    mov bp, sp
    push es
    push di
    push ax
    push bx
    push cx
    push dx

    mov ax,0xb800
    mov es,ax
    mov di,0
    mov si,[bp+6]   ;loading msg
    mov cx,[length]
    mov ah,0x07
    l12:
    mov al,[si]
    mov [es:di],ax
    add di,2
    add si,1
    loop l12
pop dx
pop cx
pop bx
pop ax
pop di
pop es
pop bp
ret 4                ;clearing stack



swap:
push ax
mov ax,[bx+si]
xchg ax,[bx+si+2]
mov [bx+si],ax
pop ax
ret

bubble_sort:
push ax
push si
l1:
mov si,0
mov byte[swaper],0

l2:
mov ax,[bx+si]
cmp ax,[bx+si+2]
jle skip
call swap
mov byte[swaper],1

skip:
add si,2
cmp si,cx
jne l2

cmp byte[swaper],1
je l1

pop si
pop ax
ret 

statOfArray:
push bp
mov bp,sp
push ax
mov bx,[bp+6]   ;start of array
mov cx,[bp+4]   ;number of elements
dec cx
shl cx,1
call bubble_sort    ;passing bx and cx as parameters

median:
mov ax,[bp+4]   ;number of elements
and ax,1    ;checking if even number of elements or odd
jz even

odd:
mov ax,[bp+4]   ;number of elements
dec ax
shl ax,1
mov si,2
div si
mov si,ax
mov ax,[bx+si]
mov [values],ax
jmp end1

even:
mov ax,[bp+4]   ;number of elements
dec ax
shl ax,1
mov cx,2
div cx  ;ax=ax/2    getting address of middle
inc ax
mov si,ax   ;we cannot [bx+ax] thats why

; now adding two middle elements
mov ax,[bx+si]
add [values],ax
add si,2
mov ax,[bx+si]
add [values],ax
mov ax,[values]
mov si,2    ;finding avg
div si
mov [bp+12],ax    ;median

end1:
mov ax,[bx] ;minimum
mov [bp+8],ax   ;moving minimum to stack
mov si,[bp+4]   ;number of elements
dec si
shl si,1

mov ax,[bx+si]  ;maximum
mov [bp+10],ax  ;pushing max to stack
pop ax
pop bp
ret 4

start:
sub sp,6    ;leaving space for min,max,median
mov ax,num
push ax
mov ax,10       ;number of elements
push ax
call statOfArray

mov bp,sp
;to print minimum
mov ax,msg1
push ax
mov ax,[bp]    ;value to print
push ax
call print


end:
mov ax,0x4c00
int 0x21
num: dw 4,5,3,2,6,7,1,2,9,10
swaper: db 0
values: dw 0,0,0
nextline: db ' ',0x0D,0x0A,'$'
msg1: db 'minimum: '
msg2: db 'maximum: '
msg3: db 'median:  '
length: dw 9
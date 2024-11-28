[org 0x100]
jmp start
print:
    push bp
    mov bp, sp

    ; Print the message
    mov dx, [bp+6]       ; Load the address of the message string into DX
    mov ah, 0x09         ; DOS interrupt to print the string
    int 0x21

    ; Print the value (assumes it's a single-digit number 0 9)
    mov bx, [bp+4]       ; Load the value to print into BX
    mov al, bl           ; Move the lower byte of BX (value) into AL
    add al, 0x30         ; Convert to ASCII (number -> character)
    mov dl, al           ; Move AL to DL (character to print)
    mov ah, 0x02         ; DOS interrupt to print the character
    int 0x21
   ; push bx
   ; push cx
   ; push ax
   ; push dx


    pop bp
    ret 4                ; Return, clean up the stack (4 bytes)



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
dec ax
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

;to print maximum
mov bp,sp
mov ax,msg2
push ax
mov ax,[bp+2]    ;value to print
push ax
call print

;to print median
mov bp,sp

mov ax,msg3
push ax
mov ax,[bp+4]    ;value to print
push ax
call print


assigning:
mov bp,sp
mov ax,[bp]  ;minimum
mov bx,[bp+2]   ;maximum
mov cx,[bp+4] ;median


end:
mov ax,0x4c00
int 0x21
num: dw 4,5,3,2,6,7,1,2,9,10
swaper: db 0
values: dw 0,0,0
nextline: db ' ',0x0D,0x0A,'$'
msg1: db 'minimum: ','$'
msg2: db 'maximum: ','$'
msg3: db 'median:  ','$'
length: dw 9
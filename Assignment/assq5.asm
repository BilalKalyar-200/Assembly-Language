;The `statsOfArray` function calculates the minimum, 
;maximum, and median values of an array by passing values
;through the stack. The array elements are pushed onto 
;the stack, and the function uses a separate sorting 
;function (like BubbleSort) to sort the array, helping
;to find the median without manually sorting within `statsOfArray`.
;The median is determined as the middle element in the sorted array,
;or the average of the two middle elements if the array has an even
;length. Once calculated, the minimum value is stored in `AX`, 
;the maximum in `BX`, and the median 
;in `CX`, and all values are printed on the console.

[org 0x100]
minn: dw 0
maxx: dw 0
medd: dw 0
jmp start
clrscr:
push ax
push es
push di

mov ax,0xb800   ;starting location of video memory
mov es,ax
mov di,0

l6:
mov word[es:di],0x0720  ;ascii of space (printing sspace with white bg)
add di,2
cmp di,1000
jne l6

pop di
pop es
pop ax
ret

print:
push bp
mov bp, sp
push es
push ax
push bx
push cx
push dx
push di

;print the message
mov ax,0xb800
mov es,ax
mov di,[bp+10]      ;where to print
mov cx,[bp+4]   ;lenght of msg
mov si,[bp+8]       ;address of msg

mov ah,0x07
l9:
mov al,[si]
mov [es:di],ax
add si,1
add di,2
loop l9

mov ax,[bp+6]
mov cx,0        ;count number of digits
mov bx,10   ;into decimals
l8:
mov dx,0
div bx
add dl,0x30 ;converting digit into ascii
push dx
inc cx
cmp ax,0
jnz l8

print_num:
pop dx
mov dh,0x07 ;attribute
mov [es:di],dx
add di,2
loop print_num



pop di
pop dx
pop cx
pop bx
pop ax
pop es
pop bp
ret 6



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

stats_of_array:
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
mov dx,0

div si
mov si,ax
mov ax,[bx+si]
mov [medd],ax   ;median
jmp end1

even:
mov ax,[bp+4]   ;number of elements
dec ax
shl ax,1
mov cx,2
mov dx,0

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
mov dx,0
mov si,2    ;finding avg
div si
mov [medd],ax    ;median

end1:
mov ax,[bx] ;minimum
mov [minn],ax   ;moving minimum to memory
mov si,[bp+4]   ;number of elements
dec si
shl si,1

mov ax,[bx+si]  ;maximum
mov [maxx],ax  ;pushing max to memory
pop ax
pop bp
ret 4

start:
call clrscr
mov ax,num
push ax
mov ax,10       ;number of elements
push ax
call stats_of_array

;to print minimum
mov ax,80
mov bx,0    ;row number
mul bx
add ax,0    ;column number
shl ax,1
mov di,ax    ;print in first line
push di
mov ax,msg1
push ax
mov ax,[minn]    ;value to print
push ax
mov ax,[length]
push ax
call print


;to print maximum
mov ax,80
mov bx,1    ;row number
mul bx
add ax,0    ;column number
shl ax,1
mov di,ax
push di
mov ax,msg2
push ax
mov ax,[maxx]    ;value to print
push ax
mov ax,[length]
push ax
call print

;to print median
mov ax,80
mov bx,2    ;row number
mul bx
add ax,0    ;column number
shl ax,1
mov di,ax

push di
mov ax,msg3
push ax
mov ax,[medd]    ;value to print
push ax
mov ax,[length]
push ax
call print
mov ax,[minn]
mov bx,[maxx]
mov cx,[medd]

end:
mov ax,0x4c00
int 0x21
num: dw 4,5,3,2,6,7,1,2,9,10
swaper: db 0
values: dw 0,0,0
msg1: db 'minimum: '
msg2: db 'maximum: '
msg3: db 'median:  '
length: dw 9
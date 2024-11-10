;This program finds a missing number from an 
;array of integers ranging from 1 to N, where 
;the array has N-1 elements and may contain 
;duplicates. First, a subroutine removes duplicates 
;from the array and stores the unique values separately.
;Then, the program calculates the missing number by comparing 
;the sum of the expected range [1, N] to the sum of elements
;in the duplicate-free array. Finally, a subroutine prints 
;the missing number to the console.


[org 0x100]
jmp start

print:
push bp
mov bp,sp
push ax
mov ax,80
mov bx,0        ;row number
mul bx
add ax,1        ;column
shl ax,1
mov di,ax
mov ax,0xb800
mov es,ax
mov si,[bp+8]   ;address of msg
mov cx,[bp+4]   ;length
mov ah,0x07
prnt:   ;loop to print message
mov al,[si]
mov [es:di],ax
add si,1
add di,2
loop prnt

mov cx,0    ;number of digits in missing number
mov ax,[miss]
mov bx,10       ;base to convert in
convertt:
mov dx,0
div bx
add dx,0x30
push dx
add cx,1
cmp ax,0
jne convertt

prntnm:
pop dx
mov dh,0x07
mov [es:di],dx
add di,2
loop prntnm

pop ax
pop bp
ret 6


remove_dub:
push bp
mov bp,sp
push ax
push bx
push cx
push dx
mov bx,[bp+6]   ;old array address
mov cx,[bp+4]   ;size of old array
dec cx
shl cx,1
mov dx,[bp+8]    ;address of new array

mov di,0    ;as 'i'
l1:
cmp di,cx   ;checking i>size
jg end1

mov ax,[bx+di]

mov si,di    ;as'j'
add si,2
mov bp,0    ;if bp=0 means no dublicate (as a flag)

l2:
cmp si,cx   ;checking j>size
jg check_flag

;push cx

;mov cx,[bx+si]  ;loads new elemetnt

cmp ax,[bx+si]
jne skip

mov bp,1    ;means dublicate found
jmp nextt

skip:
;pop cx
add si,2    ;j++
jmp l2


check_flag:     ;checks if we found dubliacte or not
cmp bp,1
je nextt    ;means yes
;else not so...
push bx
mov bx,dx
mov [bx],ax ;stores into new array
pop bx
add dx,2    ;points to next location
add word [size],2   ;increasing size of new array


nextt:
;pop cx
add di,2    ;i++
jmp l1

end1:
pop dx
pop cx
pop bx
pop ax
pop bp
ret

find_missing:
push bp
mov bp,sp
push ax
push bx
push cx
push dx
mov cx,[bp+4]   ;size
mov ax,cx
add ax,1    ;creating formula n(n+1)/2
mul cx      ;ax=ax*cx   (8*7)
mov bx,2
div bx      ;ax=ax/2
;now ax will have sum of first N elemetnts
push ax
mov bx,num2
mov si,0
mov ax,0
mov cx,[bp+6]   ;size
dec cx
shl cx,1
loop1:
add ax,[bx+si]  ;sum of all elements of new array
add si,2
cmp si,cx
jne loop1
pop bx  ;bx will have result of n(n+1)/2
sub bx,ax
mov [miss],bx

pop dx
pop cx
pop bx
pop ax
pop bp
ret 2

start:
mov ax,num2
push ax
mov ax,num
push ax
mov ax,7    ;number of elemetnts
push ax
call remove_dub
sub word[size],2    ;decrementing bcz added extra two

mov ax,7    ;number of elemetnts
push ax
call find_missing

mov ax,msg
push ax
mov ax,[miss]   ;number to print
push ax
push word [length]
call print

mov ax,0x4c00
int 0x21
num: dw 1,2,3,4,6,2,7   ;missing is five
num2: dw 0,0,0,0,0,0,0
size: dw 0
miss: dw 0h
msg: db ' '
length: dw 1
;this program prints the smiley face in a digonal
;first it calls the function to print from top to middle right of screen
;then it calls another function to print from there to bottom left
;it uses this formula to calculate where to print ->location = (row*80 + colum)*2
;where number of rows are from 0-24 and columns are from 0-79 (in each row)
;then it prints a number on 6th row in decresing triangle shape




[org 0x100]
jmp start
clrscr:
mov ax,0xb800
mov es,ax
mov di,0
l2:
mov word[es:di],0x0720
add di,2
cmp di,4000
jne l2
ret

print:
push bp
mov bp,sp
mov ax,0xb800
mov es,ax
mov ax,80           ;location = (row*80 + colum)*2
mul byte[bp+8]  ;row*80
add ax,[bp+6]   ;add column 
shl ax,1
mov di,ax
mov cx,12   ;to print till half rows
mov si,[bp+4]   ;smile
l1:
mov ah,01
mov al,[si]
mov [es:di],ax
add di,174
loop l1
pop bp
ret 6

print2:
push bp
mov bp,sp
mov ax,0x4c00
mov ax,80
mul byte[bp+8]
add ax,[bp+6]
shl ax,1
mov di,ax
mov cx,12
mov si,[bp+4]
l3:
mov ah,01
mov al,[si]
mov [es:di],ax
add di,146
loop l3
pop bp
ret 6

printnum:
push bp
mov bp,sp
mov ax,0xb800
mov es,ax
mov ax,[bp+4]       ;number to print
mov bx,10

mov cx,0
next:
mov dx,0
div bx
add dx,0x30
push dx
add cx,1
cmp ax,0
jne next

mov bx,0
mov ax,80
mov bx,6        ;row number
mul bx
add ax,0        ;column 
shl ax,1
mov di,ax
push di

outer:
mov bx,cx
mov si,-10

inner:
mov al,[bp+si]
mov ah,01
mov [es:di],ax
add di,2
add si,2
sub bx,1
cmp bx,0
jne inner

add word[bp-12],162     ;add di+162 in stack to print in next location of next row
mov di,[bp-12]

loop outer
pop di
pop ax
pop ax
pop ax
pop ax
pop ax
pop bp 
ret 2



start:
call clrscr
mov ax,1    ;row
push ax
mov ax,0    ;column
push ax
mov ax,smile
push ax
call print          ;to print from to to middle

;now printing from middle to bottom
mov ax,13   ;row
push ax
mov ax,78
push ax
mov ax,smile
push ax
call print2


;now printing number
mov ax,12345
push ax
call printnum


mov ax,0x4c00
int 0x21
smile: db 0x01
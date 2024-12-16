;this program finds the deteminent of 2D matrix
[org 0x100]
jmp start
mat: dw 6,4,3,3      ;this is 1D as we can't create 2D in assembly but we will deal it like 2D mat
left: dw 0
right: dw 0
result: dw 0

find_determinent:
push bp
mov bp,sp
mov si,[bp+4]
mov ax,[si]
add si,6
mul word[si]
 mov bx, ax
sub si,4
mov ax,[si]
add si,2
mul word[si]
sub bx,ax
mov [result],bx
pop bp
ret 2

start:
mov ax,mat
push ax
call find_determinent
mov ax,0x4c00
int 0x21
;this program calculates the lenght of a string and then prints it on screen using
;lods and stow
;also the concept of scas is used in this program and i tried to explain it little
[org 0x100]
jmp start
length:
push bp
mov bp,sp
push cx
push di
les di,[bp+4]   ;bcz scas works with DI,it takes data from 0 and compares it with ES:DI,increment DI by 2
mov cx,0xffff
xor al,al
repne scasb
mov ax,0xffff
sub ax,cx
dec ax
pop di
pop cx
pop bp
ret 4
print:
push bp
mov bp,sp
push ds
mov si,[bp+4]   ;address of msg
push si
call length
mov cx,ax   ;loads the length in cx
mov ax,0xb800
mov es,ax
mov ax,80
mul byte[bp+8]
add ax,[bp+6]
shl ax,1
mov di,ax
mov ah,07
l2:
lodsb
stosw
loop l2
pop bp
ret 8



start:
push word 2 ;row number
push word 2 ;column number
mov ax,msg
push ax
call print
mov ax,0x4c00
int 0x21
msg: db 'hello world',0
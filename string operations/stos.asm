;This program use the very important concepts
;first it finds the length of string using SCAS
;then it prints another string and then it print the lenght of first string



[org 0x100]
jmp start
find_lenght:
push bp
mov bp,sp
push ds
pop es          ;bcz the scas works with ES:DI so we will point DS to ES
mov di,[bp+6]   ;msg
mov cx,0xffff   ;max number
xor al,al       ;clear ax
repne scasb     ;this will decrement cx until null found in string
mov ax,0xffff
sub ax,cx
dec ax      ;now ax will have that length
mov si,[bp+4]   ;the index
mov [leng+si],ax
pop bp
ret 4

prnt_leng:
push bp
mov bp,sp
mov ax,[bp+4]   ;loads the msg
push ax
push word 2     ;the index
call find_lenght    ;now ax will the lenght of msg1
push ax
pop cx
mov ax,0xb800
mov es,ax
mov di,0
mov si,[bp+4]   ;the msg
cld
mov ah,01
ll:
lodsb
stosw
loop ll

mov ax,[leng]
mov bx,10       ;base
l2:
mov dx,0
div bx
add dx,0x30 ;convert ascii
push dx
add cx,1        ;number of digits
cmp ax,0
jne l2

l4:
pop dx
mov dh,01
mov [es:di],dx
add di,2
loop l4
pop bp
ret 2


start:
mov ax,msg
push ax
push word 0     ;the location to store the lenght at
call find_lenght
mov ax,msg1
push ax
call prnt_leng

mov ax,0x4c00
int 0x21
msg: db 'bilal is best',0
leng: dw 0,0,0
msg1: db'The length of string is: ',0
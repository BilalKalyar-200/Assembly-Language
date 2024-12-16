[org 0x100]
jmp start
old_loc: dd 0

my_isr:
push bp
mov bp,sp
mov ax,[bp+8]
add ax,[bp+10]
mov dx,0xb800
mov es,dx
mov bx,10
mov cx,0
l1:
mov dx,0
div bx
add dl,0x30
push dx
add cx,1
cmp al,0
jne l1
mov di,0
l2:
pop dx
mov dh,1
mov[es:di],dx
add di,2
loop l2
pop bp
iret
start:

mov ax,0
mov es,ax


cli     
mov word[es:62h*4],my_isr
mov [es:62h*4+2],cs
sti

mov ax, 15 ; number 1
push ax
mov ax, 31 ; number 2
push ax
int 62h
pop ax
pop ax
   

mov ax, 0x4c00 ; terminate program
int 0x21
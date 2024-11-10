[org 0x100]
jmp start

clrscr:
push bp
mov ax,0xb800
mov es,ax
mov di,0
l3:
mov word[es:di],0x0720
add di,2
cmp di,4000
jne l3
pop bp
ret


diamond:
push bp
mov bp,sp
mov ax,0xb800
mov es,ax
mov ax,80
mul byte[bp+8]
add ax,[bp+6]
shl ax,1
mov di,ax
mov cx,[bp+4]   ;length
mov si,-2
l1:
mov bx,[bp+4]
sub bx,cx
add bx,1
push di
l2:
mov word[es:di],0x072A
add di,4
sub bx,1
cmp bx,0
jne l2
add word[bp+si],158
pop di
loop l1
mov [bp+10],di  ;saving di
pop bp
ret 6

print2:
push bp
mov bp,sp
mov ax,0xb800
mov es,ax
;add word[bp+6],2
mov di,[bp+6]
;add di,4
mov cx,[bp+4]
sub cx,1

outer
otter:
mov bx,cx
l4:
mov ah,01
mov word[es:di],0x072A
sub bx,1
add di,4
cmp bx,0
jne l4
add word[bp+6],162
mov di,[bp+6]
loop otter
pop bp
ret 4

start:
call clrscr
sub sp,2        ;leaving space to save di
mov ax,6    ;row
push ax
push  40    ;column
mov bx,2
mov ax,[length]
mov dx,0
div bx
push ax    ;length/2    ;upper half
call diamond

pop di
add di,4
push di
mov bx,2
mov ax,[length]
mov dx,0
div bx
push ax     ;length/2

call print2
mov ax,0x4c00
int 0x21
length: dw 10
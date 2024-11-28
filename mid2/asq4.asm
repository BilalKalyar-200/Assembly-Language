[org 0x100]
jmp start

clrscr:
mov ax,0xb800
mov es,ax
mov di,0
nextl:
mov word [es:di],0x0720
add di,2
cmp di,2000
jne nextl
ret
display:
push bp
mov bp,sp
mov ax,0xb800
mov es,ax
mov di,0
mov si,[bp+6]       ;loading msg
mov cx,[bp+4]       ;loading lenght msg
strr:
mov al,[si]
mov ah,07
mov [es:di],ax
add si,1
add di,2
loop strr
;changeing the number to display    

mov ax,[sum]        ;number to display
mov bx,10

mov cx,0
change:
mov dx,0
div bx
add dx,0x30
push dx
add cx,1
cmp ax,0
jne change

nt:
pop dx
mov dh,07
mov [es:di],dx
add di,2
loop nt

pop bp
ret 4
findSum:
push bp
mov bp,sp
mov cx,[bp+4]   ;getting that s=n+5
mov bx,1
LL:
mov ax,bx
mul ax
add [sum],ax
add bx,1
loop LL
pop bp
ret 2

start:
call clrscr
mov ax,[roll]
add ax,5        ;creating thaat formula
push ax         ;as s
call findSum

mov ax,strrr
push ax
push word [leng]
call display

mov ax,0x4c00
int 0x21
roll: dw 6       ;0646
sum: dw 0
strrr: db 'sum is: '
leng: dw 8
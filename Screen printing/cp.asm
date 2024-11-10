;this program prints border of snake game and them prints the snake of different locations
;until it touched the border
;here I didn't added delay just printed by sending different locations


[org 0x100]
jmp start

clrscr:
push bp
mov bp, sp
push ax
push bx
push cx
push dx
push si
push di
mov ax, 0xb800
mov es, ax
mov di, 0

l2:
mov word [es:di], 0x0720
add di, 2
cmp di, 4000             
jne l2
pop di
pop si
pop dx
pop cx
pop bx
pop ax
pop bp
ret

snakeprint:
push bp
mov bp, sp
push es
push ax
push cx
push dx
push di
push si
mov ax,0xb800
mov es,ax
mov ax,80
mul byte[bp+10]     ;row*80
add ax,[bp+8]       ;add column
shl ax,1
mov di,ax

;call clrscr
mov cx,[bp+4]       ;lenght of snake
mov si,[bp+6]       ;snake

l3:         ;this loop will print snake on bottom right

mov ah,01
mov al,[si]
mov [es:di],ax  ;printing snake
sub di,2
add si,1
loop l3



pop si
pop di
pop dx
pop cx
pop ax
pop es
pop bp
ret 8

vertical:
;now priting vertically
push bp
mov bp, sp
push es
push ax
push cx
push dx
push di
push si
mov ax,0xb800
mov es,ax
mov ax,80
mul byte[bp+10]     ;row*80
add ax,[bp+8]       ;add column
shl ax,1
mov di,ax

;call clrscr
mov si,[bp+6]       ;snake
mov cx,[bp+4]       ;lenght of snake
l5:
mov ah,01
mov al,[si]
mov [es:di],ax
sub di,160
add si,1
loop l5

pop si
pop di
pop dx
pop cx
pop ax
pop es
pop bp
ret 8

print_border:
push bp
mov bp,sp
push es
push ax
push cx
push si
push di
mov ax,0xb800
mov es,ax

mov ax,80
mul byte[bp+8]
add ax,[bp+6]
shl ax,1
mov di,ax
mov si,[bp+4]
mov cx,80
mov ah,02   
ll:
mov al,[si]
mov [es:di],ax
add di,2
loop ll
pop di
pop si
pop cx
pop ax
pop es

pop bp
ret 6

side_border:
push bp
mov bp,sp
push es
push ax
push cx
push si
push di
mov ax,0xb800
mov es,ax

mov ax,80
mul byte[bp+8]
add ax,[bp+6]
shl ax,1
mov di,ax
mov ah,02
mov si,[bp+4]
mov cx,0
lb:
mov al,[si]
mov [es:di],ax
add di,160
add cx,1
cmp cx,23
jne lb
pop di
pop si
pop cx
pop ax
pop es

pop bp
ret 6

printmsg:
push bp
mov bp,sp
push es
push ax
push cx
push si
push di
mov ax,0xb800
mov es,ax
mov ax,80
mul byte[bp+10]     ;row*80
add ax,[bp+8]       ;add column
shl ax,1
mov di,ax
mov si,[bp+6]       ;address of msg
mov cx,[bp+4]       ;length
mov ah,03
l8:
mov al,[si]
mov [es:di],ax
add di,2
add si,1
loop l8
pop di
pop si
pop cx
pop ax
pop es

pop bp
ret 8

start:
call clrscr
;creating top borders
mov ax,0    ;row
push ax
mov ax,0    ;column
push ax
mov ax,border
push ax
call print_border

;creating bottom borders
mov ax,24    ;row
push ax
mov ax,0    ;column
push ax
mov ax,border
push ax
call print_border

;creating left border
mov ax,1    ;row
push ax
mov ax,0    ;column
push ax
mov ax,border
push ax
call side_border

;creating right border
mov ax,1    ;row
push ax
mov ax,79    ;column
push ax
mov ax,border
push ax
call side_border

;to print horizontally at bottm right
mov ax,23   ;row number
push ax
mov ax,78   ;column number
push ax
mov ax,snake
push ax
push word[length]
call snakeprint

;to print horizontally at 2 positions left from bottom right
mov ax,23   ;row number
push ax
mov ax,76   ;column number
push ax
mov ax,snake
push ax
push word[length]
call snakeprint

;to print vertical right above last horizontal print
mov ax,23   ;row number
push ax
mov ax,69   ;column number
push ax
mov ax,snake
push ax
push word[length]
call vertical

;to print vertical right above last vertical print
mov ax,17   ;row number
push ax
mov ax,69   ;column number
push ax
mov ax,snake
push ax
push word[length]
call vertical

;to print horizontally after last vertical print
mov ax,11   ;row number
push ax
mov ax,68   ;column number
push ax
mov ax,snake
push ax
push word[length]
call snakeprint

;to print horizontally at left of last horizontal print
mov ax,11   ;row number
push ax
mov ax,6   ;column number
push ax
mov ax,snake
push ax
push word[length]
call snakeprint


mov ax,3        ;row number
push ax
mov ax,38       ;col number
push ax
mov ax,msg      ;address
push ax
push word 10    ;length of msg
call printmsg

mov ax,0x4c00
int 0x21
snake: db '*****@'
length: dw 6
border: db '#'
msg: db 'game over!'
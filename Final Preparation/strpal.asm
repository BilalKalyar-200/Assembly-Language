[org 0x0100]






start:
 mov ax, 0xB800         ; Set up the video memory segment
    mov es, ax
call clrscr
call draw_borders
call draw_snake
l1:
call move_snake
call input_move
call delay
jmp l1
mov ax,0x4C00
int 21h

delay:
    push cx
    push dx
    mov cx,0xFF
    outer_delay:
    mov dx,0xFF
    inner_delay:
    dec dx
    jnz inner_delay
    dec cx
    jnz outer_delay
    pop dx
    pop cx
    ret

clrscr:
mov di,0
mov cx,2000
mov ax, 0x0720
rep stosw
ret
draw_borders:
;topborder
mov di,0
mov cx, 80
mov al,[borderchar]
mov ah, 0x07
rep stosw
;left and right
mov cx,23
mov di,160
border_loop:
mov[es:di],ax
add di,158
mov[es:di],ax
add di,2
loop border_loop
;Bottom
mov cx, 80
rep stosw
ret
draw_snake:
mov ah, 0x13
mov al,1
mov bh,0
mov bl, 0x0A
mov dh, [snake_row]
mov dl ,[snake_col]
mov cx,5
push cs
pop es
mov bp,snakechar
int 0x10
ret

resetsnake:
mov ah, 0x13
mov al,1
mov bh,0
mov bl, 0x0A
mov dh, [snake_row]
mov dl ,[snake_col]
mov cx,5
push cs
pop es
mov bp,[erase]
int 0x10
ret

move_snake:
cmp word[snake_direction], 0
je move_up
cmp word[snake_direction],1
je move_down
cmp word[snake_direction],2
je move_left
cmp word[snake_direction],3
je move_right
ret
move_up:
cmp word[snake_direction],2
jle no_move_up
call resetsnake
sub byte[snake_row],1
mov word[snake_direction],0
call draw_snake
no_move_up:
ret
move_down:
cmp word[snake_direction],23
jle no_move_down
call resetsnake
add byte[snake_row],1
mov word[snake_direction],1
call draw_snake
no_move_down:
ret
move_right:
cmp word[snake_direction],72
jle no_move_right
call resetsnake
add byte[snake_col],1
mov word[snake_direction],2
call draw_snake
no_move_right:
ret
move_left:
cmp word[snake_direction],2
jle no_move_left
call resetsnake
sub byte[snake_col],1
mov word[snake_direction],3
call draw_snake
no_move_left:
ret
mov_upper:
 call move_up
 jmp empty
 mov_downer:
 call move_down
 jmp empty
 mov_lefter:
 call move_left
 jmp empty
 mov_righter:
 call move_right
 jmp empty
input_move:
mov ah, 0x01
int 0x16
jz empty
mov ah, 0x00
int 0x16
cmp al,0x1B
je exit
cmp al, 'p'
je pausee
cmp al,'w'
je mov_upper
cmp al,'s'
je mov_downer
cmp al,'a'
je mov_lefter
cmp al, 'd'
je mov_righter

empty:
pop ax
ret
pausee:
mov ah, 0x00
int 0x16
cmp al,'p'
jne pausee
jmp empty
exit:
mov ax, 0x4c00
int 0x21
borderchar: db '*'
snakechar: db '00000'
snake_row: db 12
snake_col: db 25
erase: db ' '
snake_direction:dw 0
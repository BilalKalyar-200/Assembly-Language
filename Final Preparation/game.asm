;This program simulates simple snake game
;it moves one character on screen based on input W,A,S,D
;no borders and no winning condition was added bcz in this I just
;wanted to show how to deal with input and interrupts
[org 0x100]
jmp start
snake_row: db 12
snake: db '@'
snake_col: db 40
erase_char: db ' '
direction: dw 0     ;if 0 means it is going up,1 ->down, 2->right, 3->left
;==========game========
clrscr:
push di
push ax
push es
push cx
mov ax,0xb800
mov es,ax
mov di,0
mov ax,0x0720
mov cx,2000
rep stosw
pop cx
pop es
pop ax
pop di
ret

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
spawn_snake:
push ax
push bp
push bx
push cx
push dx
      mov ah,0x13 ;subservice
      mov al,01   ;pata nhi kia
      mov bh,0     ;page
      mov bl,1    ;attribut
      mov cx,1
      mov bp,snake
      mov dh,[snake_row]
      mov dl,[snake_col]
      int 0x10
pop dx
pop cx
pop bx
pop bp
pop ax
      ret

clear_snake:
push ax
push bp
push bx
push cx
push dx
      mov ah,0x13 ;subservice
      mov al,01   ;pata nhi kia
      mov bh,0     ;page
      mov bl,1    ;attribut
      mov cx,1
      mov bp,erase_char
      mov dh,[snake_row]
      mov dl,[snake_col]
      int 0x10
pop dx
pop cx
pop bx
pop bp
pop ax
      ret

;============move logics===========
move_snake:     ;to move the snake based on direction variable
    cmp word[direction],0
    je move_up
    cmp word[direction],1
    je move_down
    cmp word[direction],2
    je move_right
    cmp word[direction],3
    je move_left
    ret
move_up:
     cmp byte[snake_row],2   ;top boundary
     jle no_move_up
     call clear_snake
     sub byte[snake_row],1   ;move to one row up
     mov word [direction],0     ;showing up movement
     call spawn_snake
     no_move_up:
     ret
move_down:
     cmp byte[snake_row],23   ;botoom boundary
     jae no_move_down
     call clear_snake
     add byte[snake_row],1   ;move to one row down
     mov word [direction],1     ;showing down movement
     call spawn_snake
     no_move_down:
     ret
move_right:
     cmp byte[snake_col],78   ;right boundary
     jae no_move_right
     call clear_snake
     add byte[snake_col],1   ;move to one col right
     mov word [direction],2     ;showing right movement
     call spawn_snake
     no_move_right:
     ret
move_left:
     cmp byte[snake_col],2   ;left boundary
     jle no_move_left
     call clear_snake
     sub byte[snake_col],1   ;move to one col left
     mov word [direction],3     ;showing left movement
     call spawn_snake
     no_move_left:
     ret
inp_mov_snake:
push ax
      mov ah,0x01
      int 0x16
      jz returner
      mov ah,0x00
      int 0x16
      cmp al,0x1B ;esc key
      je endd
      cmp al,'p'
      je pausee
      cmp al,'w'
      je move_up_call
      cmp al,'s'
      je move_down_call
      cmp al,'d'
      je move_right_call
      cmp al,'a'
      je move_left_call
returner:
    pop ax
    ret
pausee:
    mov ah,0x00
    int 0x16
    cmp al,'p'
    jne pausee
    jmp returner
endd:
    mov ax,0x4c00
    int 0x21

        move_up_call:
            call move_up
            jmp returner
        move_down_call:
            call move_down
            jmp returner
        move_right_call:
            call move_right
            jmp returner
        move_left_call:
            call move_left
            jmp returner         
start:
call clrscr
call spawn_snake
l1:
    call move_snake
    call inp_mov_snake
    ;call delay
    call delay
    jmp l1

mov ax,0x4c00
int 0x21
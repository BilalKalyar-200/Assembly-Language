[org 0x100]

jmp start

; ==============================================
; Constants
; ==============================================
SCREEN_WIDTH equ 80      ; Screen width in characters
SCREEN_HEIGHT equ 25     ; Screen height in rows
PADDLE_HEIGHT equ 3      ; Paddle height (number of characters)
PADDLE1_COL equ 2        ; Paddle 1 column (left side)
PADDLE2_COL equ 77       ; Paddle 2 column (right side)
BALL_CHAR equ 'O'        ; Ball character
PADDLE_CHAR equ '|'      ; Paddle character
WALL_CHAR equ '-'        ; Wall character

; ==============================================
; Data Section
; ==============================================
section .data
score1 dw 0              ; Player 1 score
score2 dw 0              ; Player 2 score
paddle1_row dw 12        ; Initial row for Paddle 1 (centered)
paddle2_row dw 12        ; Initial row for Paddle 2 (centered)
ball_row dw 12           ; Initial ball row
ball_col dw 40           ; Initial ball column
ball_dir_row db -1       ; Ball vertical direction (-1 = up, 1 = down)
ball_dir_col db 1        ; Ball horizontal direction (-1 = left, 1 = right)

; ==============================================
; Subroutine: Clear Screen
; ==============================================
clrscr:
    push ax
    push cx
    push di
    mov ax, 0xb800       ; Video memory base
    mov es, ax
    mov di, 0
    mov ax, 0x0720       ; ASCII space (0x20) with white text on black (0x07)
    mov cx, 2000         ; 80x25 screen = 2000 words
rep stosw                ; Fill screen with spaces
    pop di
    pop cx
    pop ax
    ret

; ==============================================
; Subroutine: Draw Border
; ==============================================
draw_border:
    push ax
    push cx
    push di
    mov ax, 0xb800
    mov es, ax

    ; Draw top border
    mov di, 0
    mov cx, SCREEN_WIDTH
    mov al, WALL_CHAR
    mov ah, 0x07
draw_top:
    stosw
    loop draw_top

    ; Draw bottom border
    mov di, 3840         ; Row 24, column 0
    mov cx, SCREEN_WIDTH
draw_bottom:
    stosw
    loop draw_bottom

    pop di
    pop cx
    pop ax
    ret

; ==============================================
; Subroutine: Draw Paddle
; Parameters: [bp+4] = Row, [bp+6] = Column
; ==============================================
draw_paddle:
    push bp
    mov bp, sp
    push ax
    push cx
    push di
    mov ax, 0xb800
    mov es, ax
    mov cx, PADDLE_HEIGHT
    mov di, [bp+4]       ; Row
    mov bx, SCREEN_WIDTH
    mul bx               ; Calculate offset
    add ax, [bp+6]       ; Column
    shl ax, 1            ; Convert to bytes
    mov di, ax
    mov al, PADDLE_CHAR
    mov ah, 0x07
draw_paddle_loop:
    stosw
    add di, 160          ; Move to next row
    loop draw_paddle_loop
    pop di
    pop cx
    pop ax
    pop bp
    ret 4

; ==============================================
; Subroutine: Draw Ball
; Parameters: [bp+4] = Row, [bp+6] = Column
; ==============================================
draw_ball:
    push bp
    mov bp, sp
    push ax
    push di
    mov ax, 0xb800
    mov es, ax
    mov di, [bp+4]
    mov bx, SCREEN_WIDTH
    mul bx
    add ax, [bp+6]
    shl ax, 1
    mov di, ax
    mov al, BALL_CHAR
    mov ah, 0x07
    stosw
    pop di
    pop ax
    pop bp
    ret 4

; ==============================================
; Subroutine: Update Ball Position
; Moves the ball and checks for collisions.
; ==============================================
update_ball:
    push ax
    push bx
    push dx

    ; Update ball position
    mov ax, [ball_row]
    add al, [ball_dir_row]
    mov [ball_row], ax
    mov ax, [ball_col]
    add al, [ball_dir_col]
    mov [ball_col], ax

    ; Check for top/bottom collisions
    cmp byte [ball_row], 1
    jl reverse_vertical
    cmp byte [ball_row], 23
    jg reverse_vertical

    ; Check for paddle collisions
    ; Left paddle
    cmp byte [ball_col], PADDLE1_COL
    jne check_right_paddle
    mov bx, [paddle1_row]
    cmp [ball_row], bx
    jl reverse_horizontal
    add bx, PADDLE_HEIGHT
    cmp [ball_row], bx
    jle reverse_horizontal

check_right_paddle:
    ; Right paddle
    cmp byte [ball_col], PADDLE2_COL
    jne end_update
    mov bx, [paddle2_row]
    cmp [ball_row], bx
    jl reverse_horizontal
    add bx, PADDLE_HEIGHT
    cmp [ball_row], bx
    jle reverse_horizontal

    ; If ball goes out of bounds, reset
    cmp byte [ball_col], 0
    jl reset_game
    cmp byte [ball_col], SCREEN_WIDTH
    jg reset_game

end_update:
    pop dx
    pop bx
    pop ax
    ret

reverse_vertical:
    neg byte [ball_dir_row]
    jmp end_update

reverse_horizontal:
    neg byte [ball_dir_col]
    jmp end_update

reset_game:
    ; Reset ball to center
    mov byte [ball_row], 12
    mov byte [ball_col], 40
    ret

; ==============================================
; Main Loop
; ==============================================
start:
    call clrscr           ; Clear the screen
    call draw_border      ; Draw the border

    ; Draw initial paddles and ball
    mov ax, [paddle1_row]
    push ax
    push PADDLE1_COL
    call draw_paddle

    mov ax, [paddle2_row]
    push ax
    push PADDLE2_COL
    call draw_paddle

    mov ax, [ball_row]
    push ax
    mov ax, [ball_col]
    push ax
    call draw_ball

game_loop:
    call update_ball
    jmp game_loop

    ; Exit program
    mov ax, 0x4c00
    int 0x21

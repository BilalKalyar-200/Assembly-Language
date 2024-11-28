;This program prints a V-shaped pattern using 
;smiley face characters. The smileys are arranged 
;symmetrically, creating two descending and ascending
;diagonals that meet in the middle, forming a smile-like
;shape. Each smiley face is printed at a specific position,
;aligning perfectly to produce this pattern.


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
mov ax, 0xb800   ; starting location of video memory
mov es, ax
mov di, 0

l2:
mov word [es:di], 0x0720  ; ASCII space with white background
add di, 2
cmp di, 4000             ; clear entire screen (80 * 25 * 2)
jne l2
; Restore registers and return
pop di
pop si
pop dx
pop cx
pop bx
pop ax
pop bp
ret

printsmile:
    push bp
    mov bp, sp
    push es
    push ax
    push bx
    push cx
    push dx
    push di
    push si

    mov ax, 0xb800
    mov es, ax
    mov cx, 19             ; print up to 25 rows (or your max row count)

loop_rows:
    mov ax, 80             ; row width in bytes
    mul byte [bp+8]        ; multiply by row number (starting row)
    add ax, [bp+6]         ; add column offset
    shl ax, 1              ; multiply by 2 for word addressing
    mov di, ax             ; calculate starting position for this row

    mov al, [smile]        ; smiley face ASCII code
    mov ah, 0x04           ; attribute (color)
    mov [es:di], ax        ; place the smiley on screen

    add word [bp+6], 2     ; increment column position for next row
    add byte [bp+8], 1     ; increment row number
    loop loop_rows

    ; Restore registers and return
    pop si
    pop di
    pop dx
    pop cx
    pop bx
    pop ax
    pop es
    pop bp
    ret 6

printright:
push bp
mov bp,sp
mov ax,0xb800
mov es,ax
mov cx,19       ;to print till 19th row

l3:
mov ax,0xb800
mov es,ax

mov ax,80
mul byte[bp+8]  ;80* row
add ax,[bp+6]
shl ax,1
mov di,ax
mov al,[smile]
mov ah,0x04
mov [es:di],ax

add word [bp+8],1   ;to print on next row
sub byte [bp+6],2   ;to print in next column
loop l3

pop bp
ret 6
start:

call clrscr
mov ax, 2        ; start row
push ax
mov ax, 2        ; start column
push ax
mov ax, 0x04
push ax          ; smiley attribute
call printsmile
;now printing right to left
mov ax,2    ;row number     fomurla would work if we start from 0 to 24
push ax
mov ax,78   ;column number
push ax
mov ax,0x04
push ax
call printright
mov ax, 0x4c00
int 0x21

smile: db 0x01       ; ASCII for smiley face

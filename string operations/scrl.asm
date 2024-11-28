[org 0x100]
jmp start
scrolldown:
    push bp
    mov bp, sp
    push ax
    push cx
    push si
    push di
    push es
    push ds
    
    mov ax, 80            ; load chars per row in ax
    mul byte [bp+4]       ; calculate source position based on input rows
    push ax               ; save position for later use
    shl ax, 1             ; convert to byte offset (bytes per character)

    mov si, 3998          ; last location on the screen
    sub si, ax            ; adjust for source position

    mov cx, 2000          ; total number of screen locations
    ;sub cx, ax            ; count of words to move

    mov ax, 0xb800        ; set video base address
    mov es, ax
    mov ds, ax

    mov di, 3998          ; point di to lower right column

    std                   ; set auto decrement mode for movsw
    rep movsw             ; scroll up by moving words

    cld                   ; clear the direction flag after usage
    mov ax, 0x0720        ; space in normal attribute
    pop cx                ; count of positions to clear
    rep stosw 
    
    pop ds
    pop es
    pop di
    pop si
    pop cx
    pop ax
    pop bp
    ret 2

print:
push bp
mov bp,sp
push ax
push bx
push cx
push dx
push si
push di
mov ax,0xb800   ;starting location of video memory
mov es,ax
mov di,0

l1:
mov word[es:di],0x0720  ;ascii of space (printing sspace with white bg)
add di,2
cmp di,3000
jne l1

;creating top and bottom border
mov ax,0xb800
mov es,ax
mov di,0
mov bx,[bp+4]   ;getting address of border
mov ah,0x07 
mov si,3842 ;pointing to first location of last line
l2:
mov al,[bx]
mov [es:di],ax
mov [es:si],ax
add si,2
add di,2
cmp di,160
jne l2

;creating side borders
mov di, 160              ;start from second line
mov si, 3998             ;last poisition of screen
side_borders:
mov al, [bx]
mov [es:di], ax          ; Left border
mov [es:si], ax          ; Right border
add di, 160              ; Move to the start of the next row
sub si, 160
cmp di, 4000             ; 3840 = 160*24, stopping before last row
jne side_borders


;now printing snake in second line
mov ax,0xb800
mov es,ax
mov di,164
mov bx,[bp+8]   ;snake adderess
mov cx,[bp+6]   ;length
mov ah,0x07
snnake:
mov al,[bx]
mov [es:di],ax
add bx,1
add di,2
loop snnake

pop di
pop si
pop dx
pop cx
pop bx
pop ax
pop bp
ret



start:
mov ax,snake;
push ax
mov ax,[lenght]
push ax
mov ax,border
push ax
call print

mov ax,5
push ax ; push number of lines to scroll
call scrolldown ; call the scroll up subroutine

mov ax,0x4c00
int 0x21
snake: db '******@'
lenght: dw 07
border: db '#'
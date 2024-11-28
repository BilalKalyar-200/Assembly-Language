[org 0x100]
jmp start
delay:
    push cx       
    push dx
    mov cx, 0xFF 
outer_loop:
    mov dx, 0xFF 
inner_loop:
    dec dx         
    jnz inner_loop
    dec cx         
    jnz outer_loop
    pop dx      
    pop cx
    ret

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
cmp di,4000
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
stosw
mov [es:si],ax
call delay
add si,2
;add di,2
cmp di,160
jne l2

;creating side borders
mov di, 160              ;start from second line
mov si, 3998             ;last poisition of screen
side_borders:
mov al, [bx]
mov [es:di], ax          ; Left border
mov [es:si], ax          ; Right border
call delay
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

scrolldown:
push bp
mov bp,sp
mov ax,80
mul byte[bp+4]  ;number of characters to scroll
push ax
mov cx,2000     ;2000 words on screen
sub cx,ax   ;number of characters that going to be displaced
shl ax,1    ;converting to bytes

mov si,3998
sub si,ax       ;source from where the data is going to be taken
mov ax,0xb800
mov es,ax
mov ds,ax

mov di,3998     ;last location on screen
std         ;setting DF to auto Decrement
rep movsw
mov ax,0x0720   ;ascii of space with white bg
cld
mov di,0
pop cx      ;number of spaces which we got form multiplication
rep stosw   ;print space from ax
pop bp
ret 2

start:
mov ax,snake;
push ax
mov ax,[lenght]
push ax
mov ax,border
push ax
call print
mov ax,3        ;lines to scroll down
push ax
call scrolldown

mov ax,0x4c00
int 0x21
snake: db '******@'
lenght: dw 07
border: db '#'
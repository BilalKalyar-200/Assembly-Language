[org 0x100]
jmp start
print:
push bp
mov bp,sp
push ax
push bx
push cx
push dx
push si
push di
;uncomment to print space
;mov ax,0xb800   ;starting location of video memory
;mov es,ax
;mov di,0

;l1:
;mov word[es:di],0x0720  ;ascii of space (printing sspace with white bg)
;add di,2
;cmp di,3000
;jne l1

;creating top and bottom border
mov ax,0xb800
mov es,ax
mov di,960          ;starting from the line below c:\> bcz i dont want it inside
mov bx,[bp+4]   ;getting address of border
mov ah,0x03 
mov si,3842 ;pointing to second location of last line
l2:
mov al,[bx]
mov [es:di],ax
mov [es:si],ax
add si,2
add di,2
cmp di,1120
jne l2

;creating side borders
mov di, 960              ;start from second line after c:/>
mov si, 3998             ;last poisition of screen
mov ah,0x01
side_borders:
mov al, [bx]
mov [es:di], ax          ; Left border
mov [es:si], ax          ; Right border
add di, 160              ; Move to the start of the next row
sub si, 160
cmp di, 4000             
jne side_borders


;now printing snake in second line
mov ax,0xb800
mov es,ax
mov di,1124
mov bx,[bp+8]   ;snake adderess
mov cx,[bp+6]   ;length
mov ah,0x02
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

push word[lenght]
mov ax,border
push ax
call print


mov ax,0x4c00
int 0x21
snake: db '******@'
lenght: dw 07
border: db '#'
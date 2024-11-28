[org 0x100]
jmp start

processor:
push bp
mov bp,sp
sub sp,10       ;creating 5 local variables
push di
push si
push dx
push cx 
push bx
push ax
mov word[bp-2],4 
mov word[bp-4],3 
mov word[bp-6],5 
mov word[bp-8],8 
mov word[bp-10],6 
add sp,10
;popping
pop ax
pop bx
pop cx
pop dx
pop si
pop di
;extracting those outputs
mov ax,[bp+14]
mov bx,[bp+12]
mov cx,[bp+10]
pop bp

ret 14

display:
push ax
mov ax,0xb800
mov es,ax
mov di,0
pop ax
mov ah,07
mov bh,07
mov ch,07
add al,0x30
add bl,0x30
add cl,0x30
mov [es:di],ax
add di,160
mov [es:di],bx
add di,160
mov [es:di],cx
ret

start:
;pushing 4inputs and 3output variables
push word 0
push word 6
push word 4
push word 6
;output
push word 4
push word 5
push word 6
call processor
call display


mov ax,0x4c00
int 0x21

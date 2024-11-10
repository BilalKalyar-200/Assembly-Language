[org 0x100]
jmp start
clrscr:
push ax
push es
push di

mov ax,0xb800   ;starting location of video memory
mov es,ax
mov di,0

l6:
mov word[es:di],0x0720  ;ascii of space (printing sspace with white bg)
add di,2
cmp di,3000
jne l6
pop di
pop es
pop ax
ret

disp:
push bp
mov bp,sp
push ax
mov ax,0xb800
mov es,ax
mov ax,80
mul byte[bp+6]
add ax,[bp+4]
shl ax,1
mov di,ax
mov cx,0
mov bx,10
pop ax
ll:
mov dx,0
div bx
add dx,0x30
push dx
add cx,1
cmp ax,0
jne ll

l4:
pop dx
mov dh,07
mov [es:di],dx
add di,2
loop l4
pop bp
ret 4

processor:
push bp
mov bp,sp
sub sp,2    ;creating space for local variable
push ax
push bx
push cx
push dx 
push si
push di
mov word[bp-2],4        ;moving 4 in that local variable

mov ax,[bp+16]  ;first input
add ax,[bp+14]  ;second input
mov [bp+8],ax   ;first output
mov ax,[bp+12]  ;third input
add ax,6
sub ax,1 
mov [bp+6],ax    ;second output
mov ax,[bp+10]  ;fourth input
add ax,[bp-2]   ;adding in that local variable
mov [bp+4],ax   ;third output
add sp,2

;popping
pop di
pop si
pop dx
pop cx
pop bx
pop ax
mov sp,bp
pop bp

ret 


start:
call clrscr
;pushing 4inputs and 3output variables
push word 6         ;lahore temp
push word 4         ;fsd temp
push word 10        ;islamabad temp
push word 2         ;murree temp
;3 outputs
push word 0
push word 0
push word 0
call processor

;using those outputs from stack
pop ax
push word 0 ;row
push word 0 ;column
call disp       ;prinitn first output

pop ax
push word 1 ;row
push word 0 ;column

call disp       ;prinitn second output

pop ax
push word 2 ;row
push word 0 ;column


call disp       ;prinitn third output

mov ax,0x4c00
int 0x21

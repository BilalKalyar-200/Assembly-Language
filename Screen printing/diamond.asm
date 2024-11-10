;This program print diamond of numbers
;                   1
;                  1 2
;                 1 2 3
;                  1 2
;                   1
;AND THE CODE IS GENERIC JUST CHANGE THE LENGHT THE TRAINLGE WILL INCREASE 



[org 0x100]
jmp start
clrscr:
push bp
mov ax,0xb800
mov es,ax
mov di,0
l3:
mov word[es:di],0x0720
add di,2
cmp di,4000
jne l3
pop bp
ret

printt:     ;to print upper diamond
push bp
mov bp,sp
mov ax,0xb800
mov es,ax
mov ax,80
mul byte[bp+8]
add ax,[bp+6]
mov di,ax
shl di,1
;now di has addresss of middle of row 3
;pushing to use this again


mov si,-2
mov cx,[bp+4]   ;length/counter
mov bx,0        ;using like j in c++
outer:
push di
mov al,1
mov bx,[bp+4]
sub bx,cx
add bx,1
add al,0x30
inner:
mov ah,01
mov [es:di],ax
add al,1

add di,4
sub bx,1
cmp al,0x39     ;this condtion checks if number to print is greater than 10 or not 
                ;if yes it converts it into alphabets to display A B C for 10,11,12 repectively
jg change

cmp bx,0
jne inner
l2:
add word[bp+si],158
pop di      ;we will use this di location to print lower half
loop outer
pop bp
ret 6

change:
add al,0x07
cmp bx,0
jne inner
jmp l2

print2:
push bp
mov bp,sp
mov di,[bp+6]
mov cx,[bp+4]   ;length
sub cx,1
mov ax,0xb800
mov es,ax

otter:
mov al,1
add al,0x30
mov bx,cx
l4:
mov ah,01
mov [es:di],ax
sub bx,1
add ax,1
add di,4
cmp bx,0
jne l4
add word[bp+6],162
mov di,[bp+6]
loop otter
pop bp
ret 4

start:
call clrscr
mov ax,3    ;row
push ax
mov ax,40   ;column
push ax
push word [length]  ;counter
call printt
add di,4
push di     ;from where we will start printing next half
push word[length]
call print2


mov ax,0x4c00
int 0x21
length: dw 7
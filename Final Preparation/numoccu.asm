;This program finds the number of times msg2 occured in msg1
;printts that number

[org 0x100]
jmp start
msg1: db '23F-0581 23F',0
msg2: db '23F',0
prnt_not: db 'not found',0
prnt_1: db 'founded',0
flag_found: db 0
incr: dw 0      ;creating this to move to next string character each time
numm: dw 0
strlen:
push bp
mov bp,sp
push cx
push di
push si

push ds
pop es
mov di,[bp+4]
mov cx,0xFFFF
mov al,0
repne scasb
mov ax,0xFFFF
sub ax,cx
dec ax
pop si
pop di
pop cx
pop bp
ret 2

compare_str:
push bp
mov bp,sp
lds si,[bp+8]
les di,[bp+4]   ;msg 2
push di
call strlen
mov bx,ax   ;msg2 lenght
push si
call strlen
;push ax ;saving the lenght

l1:
    mov si,[bp+8]   ;gets the original address
    mov di,[bp+4]
    add si,[incr]   ;to increment each time this would help us to start from next bit onn each iteration
    add word [incr],1
    mov cx,bx   ;msg 2 lenght   
    repe cmpsb
    cmp cx,0    ;if msg 2 lenght is 0
    je found
    cmp ax,[incr]
    jg l1
    jmp end


found:
mov byte [flag_found],1
add word [numm],1
jmp l1
end:

pop bp
ret 
prntstr:
push bp
mov bp,sp
mov ax,[bp+4]
mov bp,ax
push bp
call strlen
mov cx,ax
mov bh,0    ;page
mov ah,0x13
mov al,01   ;cursor
mov dx,0x0901 ;row/col
mov bl,01  ;attri
int 0x10
pop bp
ret 2

start:
;mov byte[found],0
push ds
mov ax,msg1
push ax
push ds
mov ax,msg2
push ax
call compare_str
cmp byte[flag_found],1

jne noo
mov ax,0xb800
mov es,ax
mov di,160
mov ax,[numm]
add ax,0x30
mov ah,01
mov [es:di],ax
jmp endd
noo:
mov ax,prnt_not
push ax
call prntstr
endd:
mov ax,0x4c00
int 0x21
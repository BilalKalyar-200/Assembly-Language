;This program convert a string into integer

[org 0x100]
jmp start
strr: db '1234',0
convertedd: dw 0
pre: dw 0

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
pop si
pop di
pop cx
pop bp
ret 2

convert:
mov si,strr
push si
call strlen
mov cx,ax   ;lenght
mov bx,10
mov ax,0
l1:
    mov dx,0
    mov [pre],ax
    lodsb
    mov ah,0
    sub al,'0'
    push cx
    mov ch,0
    mov cl,al
    mov ax,[pre]
    mul bx
    add al,cl
    pop cx
    loop l1
done:
mov ax,[pre]
    mov [convertedd],ax
ret
print_num:
    mov bx,10
    mov dx,0xb800
    mov es,dx
    mov cx,0
    mov ax,[convertedd]
    nextt:
        mov dx,0
        div bx
        add dl,0x30
        push dx
        inc cx
        cmp ax,0
        jnz nextt
    mov di,0
    nextt1:
        pop dx
        mov dh,0x07
        mov [es:di],dx
        add di,2
        loop nextt1
    ret
start:
call convert
call print_num

mov ax,0x4c00
int 0x21
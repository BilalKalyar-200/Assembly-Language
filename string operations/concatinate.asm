
;This program concatinates two strings



[org 0x100]
jmp start
message: db 'hello world'
msg: db 'bilal says '
concatinate: times 256 db 0 
length: dw 11
new_len: dw 0

clrscr:

mov ax,0xb800
mov es,ax
mov di,0
mov al,0x20
mov ah,0x07
mov cx, 2000
cld
rep stosw
ret

printstr:
    push bp
    mov bp, sp
    push es
    push ax
    push cx
    push si
    push di
    mov ax, 0xb800
    mov es, ax
    mov al, 80
    mul byte [bp+10]
    add ax, [bp+12]
    shl ax, 1
    mov di, ax
    mov si, [bp+6]
    mov cx, [bp+4]
    mov ah, [bp+8]
    cld
nextchar:
    lodsb
    stosw
    loop nextchar
    pop di
    pop si
    pop cx
    pop ax
    pop es
    pop bp
    ret 10
concatinate2:
push bp
mov bp,sp
mov ax,ds
mov es,ax   ;data segment (to get the data from)
mov si,[bp+6]       ;index to start writing from
mov di,concatinate      ;points where we want to write
add di,si
mov si,[bp+8]       ;msg

mov cx,[bp+4]       ;length
cld
l1:
lodsb
stosb
add word [new_len],1
loop l1
pop bp
ret 4
start:
    call clrscr
    mov ax,msg
    push ax
    push word 0
    push word 11 ;length of msg
    call concatinate2

mov ax,message
    push ax
    push word 11        ;index of new string where to start writing from
    push word 11 ;length of msg
    call concatinate2

    mov ax, 30
    push ax
    mov ax, 20
    push ax
    mov ax, 1
    push ax
    mov ax, concatinate
    push ax
    push word [new_len]        ;new length
    call printstr
    mov ax, 0x4c00
    int 0x21

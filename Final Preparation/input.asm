;This program takes input from user using keyboard
[org 0x100]
jmp start
strr: db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0

;bilal is best
;jj is chrull

start:
mov di,strr
push ds
pop es
mov cx,0   ;number of characters inputted
l1:
    mov ah,0x00
    int 0x16    
    cmp al,0x0D ;check for enter key
    je done
    stosb
    add cx,1
    mov dl, al
    mov ah, 0x02            ;to show while taking input
    int 0x21
    
    cmp cx,17   ;max 10 input limit
    jne l1
    done:
  
    mov bp,strr     ;msg address
    mov ah,0x13     ; service (string printing)
    mov bl,1    ;attribute
    mov bh,0        ;
    mov al,01
    mov dx,0x0401
    int 0x10
mov ax,0x4c00
int 0x21


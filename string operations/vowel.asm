
;this program first converts a msg into lower case and then counts number of vowels in it



[org 0x100]
jmp start
msg: db 'AEIOU bilal'
length: dw 11
vowel: db 'aeiou'
len: dw 5  ;of vowels
ans: dw 0
msgg: db 'number of vowels in message are: '
ln: dw 33   ;of new msg
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
    pop si
    pop cx
    pop ax
    pop es
    pop bp
    ret 10

checkVowel:
mov si,msg
mov cx,[length]
l1:
mov di,vowel
mov bx,[len]        ;lenght of vowels
mov al,[si]     ;loads current character from string
inner:
cmp al,[di]
je addd
add di,1    ;points to next vowel
dec bx
cmp bx,0
jne inner
jmp skip

addd:
inc word [ans] 
skip:
add si,1    ;to get next character
loop l1

ret

printer:
mov ax,0xb800
mov es,ax
mov ax,[ans]
mov ah,07
add al,0x30
mov [es:di],ax
ret

;this function will convert all upper cases to lower
converts:
push bp
mov bp,sp
mov si,[bp+6]   ;msg
mov cx,[bp+4]   ;length
ll:
mov al,[si]
cmp al,'a'
jl converrt
jmp skipp

converrt:
cmp al,0x20       ;compare with space to ignore
je skipp
add al,32       ;the difference between ascii of upper and lower case
mov [si],al     ;fix the string
skipp:
add si,1
loop ll
pop bp
ret 4
start:
call clrscr

mov ax, 1
push ax         ;col
mov ax, 1
push ax     ;row
mov ax, 1 
push ax     ;attribute
mov ax, msg
push ax 
push word [length] 
call printstr


mov ax,msg
push ax
push word[length]
call converts

mov ax, 1
push ax         ;col
mov ax, 2
push ax     ;row
mov ax, 1 
push ax     ;attribute
mov ax, msg
push ax 
push word [length] 
call printstr

call checkVowel
mov ax, 1
push ax         ;col
mov ax, 3
push ax     ;row
mov ax, 1 
push ax     ;attribute
mov ax, msgg
push ax 
push word [ln] 
call printstr

call printer
mov ax, 0x4c00
int 0x21

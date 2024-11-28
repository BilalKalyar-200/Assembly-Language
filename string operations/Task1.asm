;this program compares two strings using LES and LDS 
;If the string are same then the flag would have value 1 otherwise it will have 0



[org 0x100]
jmp start
length:
push bp
mov bp,sp
push cx
push di
les di,[bp+4]   ;bcz scas works with DI,it takes data from 0 and compares it with ES:DI,increment DI by 2
mov cx,0xffff
xor al,al
repne scasb
mov ax,0xffff
sub ax,cx
dec ax
pop di
pop cx
pop bp
ret 4

compare:
push bp
mov bp,sp
les di,[bp+4]
lds si,[bp+8]
push ds
push di
call length ;lenght of first msg
mov cx,ax
push ds
push si
call length ;lenght of second msg
cmp ax,cx
jne exit1   ;if size not match then both strings are not same
mov ax,1        ;as a flag to check if they are equal or not
rep cmpsb
jcxz exit2
exit1: mov ax,0
exit2:
pop bp
ret 8


start:
push ds
mov ax,str1
push ax
push ds
mov ax,str2
push ax
call compare
cmp ax,1
jne nott
mov byte [flag],1
jmp end
nott:
mov byte [flag],0
end:
mov ax,0x4c00
int 0x21
str1: db 'this is bilal',0
str2: db 'this is not bilal',0
flag: db 0
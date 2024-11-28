;this program finds the first occurence of 123 in a string
;first it finds the lenght and then traverse

[org 0x100]
jmp start
str1 db 'abc12xyz13456123',0
find_length:
push bp
mov bp,sp
les di,[bp+4]
mov cx,0xffff
xor al,al
repne scasb
mov ax,0xffff
sub ax,cx
dec ax
pop bp
ret 2

find_index:
push bp
mov bp,sp
lds si,[bp+4]   ;loads msg 
mov cx,[bp+8]   ;length of string
mov bx,0        ;the index of occurence of #
l1:
lodsb   ;moving current character from string to al
cmp al,'1'  ;if 1 is found then we will check for next two characters 2,3
je compare
add bx,1
cmp bx,cx
jle l1
back:
add bx,2    ;bcz we already proceeded another character
cmp bx,cx
jle l1
jmp end1
compare:
lodsb   ;loads next character
cmp al,'2'
jne back
add bx,1    ;bcz by our next return (if not found) we had used two more characters form string
lodsb   ;loads next character
cmp al,'3'
jne back
end1:
pop bp 
ret 4

start:
push ds
mov ax,str1
push ax
call find_length

push ax ;lenght of string
push ds
mov ax,str1    ;address of string
push ax
call find_index     ;function to find index of occurence of # in string
mov ax,0x4c00
int 0x21
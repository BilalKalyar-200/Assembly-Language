[org 0x100]

mov bx,1	;i
mov cx,4
l1:
mov al,[num+bx]	;key
sub bx,1
mov si,bx	;j
add bx,1

chk1:
cmp si,0
jge chk2
jmp l3

chk2:
cmp [num+si],al
jg l2
jmp l3

l2:
mov dl,[num+si]
mov [num+si+1],dl
sub si,1
jmp chk1
l3:
mov [num+si+1],al
add bx,1
loop l1


mov ax,0x4c00
int 0x21
num: db 4,3,2,5,3
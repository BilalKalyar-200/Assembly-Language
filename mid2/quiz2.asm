[org 0x100]

mov al,0
mov si,quiz2
mov bx,quiz2
add bx,1
mov cx,7
mov dl,0

my_loop:
add al,[si]
add dl,[bx]
add si,2
add bx,2
sub cx,1
jnz my_loop

sub al,dl
mov [marks],al
mov ax,0x4c00
int 0x21
quiz2: db 2,3,4,5,6,7,8,9,10,11,12,13,14,20
marks: db 0
[org 0x100]


mov si,num1
mov bx,num2
mov di,num3
mov cx,5


my_loop:
mov ax,[si]
mov dl,[bx]
add ax,dx
mov [di],ax


add si,2
add bx,1
add di,4
loop my_loop  ;while(cx!=0){cx--)
mov ax, 0x4C00 
int 0x21  

num1: dw 5,10,15,20,25
num2: db 1,2,3,4,5,6
num3: dd 0,0,0,0,0


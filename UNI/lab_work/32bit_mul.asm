[org 0x100]

mov ax,[num]          ;stores lower bit
mov bx,[num+2]       ;stores upper bits

mov bx,[p]           ;loads multiplier
mov cx,16
mov si,0
mov di,0

l1:
shr bx,1         ; shifting multiplier
jnc skip
add di,ax        ;add lower part
adc si,dx        ;add upper part

skip:
shl ax, 1
rcl dx, 1
loop l1
mov [result],di      ;stores lower half of result
mov [result+2],si	;stores upeer half of result

mov ax, 0x4c00
int 0x21

num: dd 1300
p: dw 500
result: dd 0

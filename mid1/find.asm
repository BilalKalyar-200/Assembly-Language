[org 0x100]

mov ax,0
mov bx,0



L1:
mov ax,[num+bx]
add bx,2
cmp bx,20
jne L2


L2:
cmp ax,0
je found_zeroo

cmp ax,20
je found_twentyy

jmp L1 
 
found_zeroo:
mov byte [found_zero] , 1
jmp L1


found_twentyy:
mov byte [found_twenty] , 1
jmp L1

cmp byte [found_zero] , 1
setz al

cmp byte [found_twenty] , 1
setz bl

mov ax,0x4c00
int 0x21

found_zero: db 0         
found_twenty: db 0
num: dw 1,2,0,4,5,6,7,8,20,9
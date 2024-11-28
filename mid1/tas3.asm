[org 0x0100]

mov si,num
add si ,5
mov bx,num
mov cx,0
L1:  
cmp cx,2
jz end
add bx,cx
sub si,cx


cmp byte [bx],[si]
jz L1
jmp set


 



set:

mov byte [result],1

end:

mov ax,0x4c00
int 0x21
num: db 1 ,2 ,3 ,2, 1
result:  db 0
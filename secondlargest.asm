[org 0x100]

mov ax,0
mov bx,0
mov cx,0	;containing largest
mov dx,0    ;conatining second largest

l1:
mov ax,[num1+bx]
add bx,2
cmp bx,20
je end

cmp ax,cx
ja swap
jmp l1
swap:
mov si,cx ;temporaryly storing largest
mov cx,ax ;moving largest to cx
mov dx,si ;moving old largest to second largest
jmp l1

end:
mov ax,0x4c00
int 0x21
num1: dw 6,7,8,4,5,3,8,9,1,2
swaper: db 0
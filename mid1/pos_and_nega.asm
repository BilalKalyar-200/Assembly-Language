[org 0x100]

mov di,0;will show number of positives
mov si,0;will show number of niggatives
mov bx,0

l1:
mov ax,[num+bx]
add bx,2
cmp bx,20
je end
cmp ax,0
jg positive
cmp ax,0
jl nigga

positive:
inc si
jmp l1

nigga:
inc di
jmp l1


end:
mov ax,0x4c00
int 0x21
num: dw -1,2,3,-4,-6,4,-8,3,6,-9
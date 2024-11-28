;this program finds a desired number from 32bit array (the number to find is stored in another place)
;and after finding store the index of number in another place


[org 0x100]

mov bx,0  ;to check lower part of num
mov si,2  ;to check upper part of num

l1:
mov ax,[num+bx]
cmp ax,[find]
je found
mov ax,[num+si]
cmp ax,[find]
je found2
add bx,4
add si,4
cmp bx,32
je end
jmp l1

found:
mov [att],bx
jmp end

found2:
mov [att],si
jmp end

end:
mov ax,0x4c00
int 0x21
num: dd 1,2,3,4,5,6,7,8,9,10
find: dd 5
att: db 0
[org 0x100]
mov ax,2222h
mov bx,0
mov word[bx + 0], 10
mov word[bx + 2], 20
mov ax,[bx+2]
mov ax,num
shr ah,02
mov ax,21 ;the number to check 
mov cx,2 
div cx		;actually it is ax=ax/cx  and reminder in dx
cmp dx,0
jne found
jmp end

found:
mov bx,1	;if we get remainder than it means number is odd so bx would be 1 for that

end:
mov ax,0x4c00
int 0x21
num: dw 5h,10H,6,7,11010h,0
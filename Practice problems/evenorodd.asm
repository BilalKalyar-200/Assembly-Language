[org 0x100]

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

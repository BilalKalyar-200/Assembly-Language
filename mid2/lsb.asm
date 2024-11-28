;this program calculates the number of one bits in BX and complement an equal 
number of least significant bits in AX.  
HINT: Use the XOR instruction 



[org 0x100]

mov bx,0110b
mov ax,0101b
mov cx,0	;it will have number that will show the number of 1's in bx
mov dx,bx

;finding number of 1's in bx
l1:
shr bx,1
jnc skip
add cx,1

skip:
cmp bx,0
jnz l1

;done finding
;now we will create a mask that will help us in complementing

mov bx,1

l2:

shl bx,1
sub cx,1

jnz l2

sub bx,1

xor ax,bx


end:
mov ax,0x4c00
int 0x21

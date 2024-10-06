;this program swaps the nibbles in each byte of the AX register
;if ax = ABCD after this program ax = BADC

[org 0x100]

mov ax,0xABCD

mov bl,al
and al,0x0F
and bl,0xF0
shl al,4
shr bl,4

or al,bl

mov bh,ah
and ah,0x0F
and bh,0xF0
shl ah,4
shr bh,4

or ah,bh

end:
mov ax,0x4c00
int 0x21

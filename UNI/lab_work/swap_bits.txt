;This program first stores the original number in ax and its copy
;in bx.
;Then it masks to turn on only even bits and store them in bx
;And same for odd bits and stores the result in ax



[org 0x100]

mov ax,0x0646

mov bx,ax ; copying

masking:

and bx,0xAAAA ; turning on even bits
and ax,0x5555 ; turning on odd bits
shr bx,1

shl ax,1

or ax,bx

mov ax,0x4c00
int 0x21

; this program multiplies the number by 3 just by using shift/rotate command
[org 0x100]


mov ax, 6   
shl ax, 1               ;multiplying by two

ror ax, 15              ;Rotate right by 15 bits to combine with the original number (AX = 12 + 6)



;OR JUST ADD ORIGINAL NUMBER AFTER SHL

mov ax, 0x4C00        
int 0x21






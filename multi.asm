[org 0x100]

mov ax, [num]        ;lower 16 bits
mov dx, [num+2]      ;upper 16 bits
;divided it bcz we cannot directly store 32 bits bcz registers are 16 bits

mov bx, [p]          ;loads the multiplier
mov cx, 16           ;as multiplier is 16 bit so we need to iterate 16 times in case of large number

mov si,0
mov di,0


l1:
shr bx, 1             ;shift right p
jnc skip              ;if no carry... skip the addition

add di, ax            ;add lower 16 bits of result
adc si, dx            ;add upper 16 bits of result with carry
    
skip:
shl ax, 1             ; Shift left lower half
rcl dx, 1             ; Rotate uuper half left through carry
loop l1               

; Store the result in result memory
mov [result], di         ;store the lower half of result in memory
mov [result+2], si       ;store the upper half of result in memory

end:
mov ax, 0x4c00
int 0x21

num: dd 1000000            ;32-bit multiplicand
p: dw 50                 ; 16-bit multiplier
result: dd 0             ; 32-bit result

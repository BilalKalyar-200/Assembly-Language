[org 0x100]

mov eax, [num]     ; Load 32-bit num into eax
mov ebx, [p]       ; Load 16-bit p into ebx (it can be promoted to 32-bit automatically)
mov ecx, 6        ; Set loop counter to 16 since p is 16-bit

xor edx, edx       ; Clear edx, to store the result (edx will be 32-bit)

l1:
    shr ebx, 1         ; Shift right p
    jnc skip           ; If carry flag is clear (no carry), skip addition
    
    add edx, eax       ; If carry, add eax to edx (result)
    
skip:
    shl eax, 1         ; Shift eax left by 1 (double eax)
    loop l1            ; Decrease ecx and loop if not zero

mov [result], edx    ; Store the result in memory

end:
mov ax, 0x4c00       ; Exit program
int 0x21

num: dd 10000
p: dw 50
result: dd 0

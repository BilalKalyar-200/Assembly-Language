[org 0x0100]    ; set origin

start:
    mov ax, 0xABCD     ; AX = 1010 1011 1100 1101 (example number)
    
    ; Mask and shift even and odd bits
    mov bx, ax         ; Copy AX to BX for manipulation
    
    ; Mask even bits (1010 1011 1100 1101 -> 1010 1010 1100 1100)
    and ax, 0xAAAA     ; Mask to keep only even bits (binary: 1010 1010 1010 1010)
    shr ax, 1          ; Shift even bits right by 1 position
    
    ; Mask odd bits (1010 1011 1100 1101 -> 0101 0101 0011 0011)
    and bx, 0x5555     ; Mask to keep only odd bits (binary: 0101 0101 0101 0101)
    shl bx, 1          ; Shift odd bits left by 1 position
    
    ; Combine the shifted even and odd bits
    or ax, bx          ; OR the results to combine both even and odd swapped bits
    
    ; AX now contains swapped bits
    
    mov ax, 0x4C00     ; terminate program
    int 0x21           ; DOS interrupt to exit
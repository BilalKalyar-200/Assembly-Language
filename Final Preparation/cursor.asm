[org 0x100]
jmp start
my_string db 'Hello, World!', 0 
str2 db 'hello again',0


start:
    mov si, my_string    ; SI points to the start of the string

print_loop:
    mov al, [si]         ; Load the current character
    cmp al, 0            ; Is it the null terminator (0)?
    je done              ; If yes, stop printing
    mov ah, 0x0E         ; BIOS teletype mode
    int 0x10             ; Print the character
    inc si               ; Move to the next character
    jmp print_loop       ; Repeat the 
    
    mov ah, 0x0E         ; BIOS teletype subfunction
    mov al, 0x0D         ; Carriage return (return to start of line)
    int 0x10
    ;mov al, 0x0A         ; Line feed (move down to the next line)
    ;int 0x10
done:
mov ah, 0x0E         ; BIOS teletype ubfunction
    mov al, 0x0D         ; Carriage return (return to start of line)
    int 0x10
    mov al, 0x0A         ; Line feed (move down to the next line)
    int 0x10
    mov si,str2
print_loop2:
    mov al, [si]         ; Load the current character
    cmp al, 0            ; Is it the null terminator (0)?
    je done2              ; If yes, stop printing
    mov ah, 0x0E         ; BIOS teletype mode
    int 0x10             ; Print the character
    inc si               ; Move to the next character
    jmp print_loop2       ; Repeat the loop
done2:
    mov ah, 0x4C         ; Exit program
    int 0x21

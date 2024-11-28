[org 0x100]  ; Set origin for COM file

jmp start    ; Jump to start of the program

fact:
    mov bp, sp        ; Set base pointer to stack pointer
    mov ax, [bp+2]    ; Get the value from the stack (passed number)

    cmp ax, 1         ; Compare if number is 1
    jle base_case     ; If number <= 1, jump to base_case

    dec ax            ; Decrement number (n-1)
    push ax           ; Push (n-1) onto the stack
    call fact         ; Recursive call to fact(n-1)

    pop bx            ; Pop (n-1) from the stack
    mov ax, [bp+2]    ; Get the original number (n)
    mul bx            ; Multiply n * fact(n-1)

    jmp done          ; Jump to done

base_case:
    mov ax, 1         ; Base case: factorial of 0 or 1 is 1

done:
    ret               ; Return to caller

start:
    mov ax, num       ; Load the number (num = 5)
    push ax           ; Push the number onto the stack
    call fact         ; Call the fact procedure

    ; Terminate program
    mov ax, 0x4c00    ; DOS interrupt to exit
    int 0x21

num dw 5              ; Define number for factorial

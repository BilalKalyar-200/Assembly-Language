[org 0x100]    ; Set origin for COM file

mov dx, msg    ; Load the address of the string into DX register
mov ah, 0x09   ; DOS function: print string
int 0x21       ; Call DOS interrupt 21h

; Exit program
mov ax, 0x4C00 ; Prepare to exit
int 0x21       ; DOS interrupt to terminate the program

msg db 'Hello, World!', 0x0D, 0x0A, '$'  ; Define the string to print


;to print on cmd
;first mount the folder
;then nasm string.asm -o fir.com
;fir.com (not afd)

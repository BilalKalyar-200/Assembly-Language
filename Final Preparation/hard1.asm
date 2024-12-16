;this program just shows that usage of hardware interrupt
;press left shift or right shift it will print using hardware interrupts
[org 0x100]
jmp start
esc_flag: db 0
my_isr:
push ax
push es
mov ax, 0xb800
mov es, ax

in al,0x60      ;hardware interrupt to envoke keyboard
cmp al,0x01
je escc

cmp al,0x2a
jne next_cmp
mov byte[es:0],'L'
mov byte[es:1],01
next_cmp:
cmp al,0x36
jne nomatch
mov byte[es:0],'R'
mov byte[es:1],01
jmp nomatch
escc:
mov byte[esc_flag],1
nomatch:
mov al,0x20
out 0x20,al
pop es
pop ax
iret
start:
mov ax,0
mov es,ax
mov word[es:9*4],my_isr
mov word[es:9*4+2],cs
l1:
cmp byte[esc_flag],1
je end

jmp l1
end:

mov ax,0x4c00
int 0x21
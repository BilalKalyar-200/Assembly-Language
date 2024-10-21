[org 0x100]

mov ax,1234
mov [num4],ax ;to store original number
mov cx,4
mov bx,0
LOOP1:

div word [num]
mov [num3],dx
;here i am going to do bx = bx*10 + dx

mov word [num2],ax  ;storing ax in memory to stop it from lossing
mov ax,bx         ;moving bx to ax
mul word [num]         ;here ax=ax* 10 (so i get one part of palindrome formula done in ax)
add ax,[num3]		 ;adding reminder to ax to complete the formula
mov bx,ax	 ;moving ax back to bx
mov ax,word [num2] ;moving original ax back 
sub cx,1
jnz LOOP1

cmp bx,[num4]
je yes
jmp end

yes:
setz bx  ;set bx to 1 if is palindrome
end:
mov ax,0x4c00
int 0x21
num: dw 10
num2: dw 0
num3: dw 0
num4: dw 0

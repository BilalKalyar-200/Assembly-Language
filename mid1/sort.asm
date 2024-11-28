[org 0x100]

mov bx, 0        ;bx is for outer loop like we use 'i' in c++

i_loop:      
mov si, 0        ;using si for inner loop like 'j' in c++ that resets after each i iteration
mov cx, 10       ;its like j=10 (but not on si) it will check for all elements with 1 element

j_loop:

mov ax, [num + si]  
mov dx, [num + si + 2] 
cmp ax, dx      
ja swap         ;jump if above

jmp continue_inner 

swap:            
mov [num + si + 2], ax  
mov [num + si], dx     


continue_inner:
add si, 2        ;almost same as j++
loop j_loop      ;until cx!=0

inc bx           ;same as i++
cmp bx, 9        ;i<10  check here
jne i_loop   


mov ax, 0x4c00   
int 0x21

num: dw 1,4,3,5,6,7,8,9,10,11  

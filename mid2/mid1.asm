;This program first sorts the array that contains the data(salary amount) of different families in descending order by using bubble sort algorithm
;Then it stores the least 5 salaries into vulnerable families array
;Then it stores the top 5 salaries into taxable families array
;Then it takes number from taxable array and subtract 30 from them and adds with corresponding index of vulnerable families


[org 0x100]
start:
mov bx,0
mov byte [swaper],0

loop1:
mov ax,[income_data+bx]
mov dx,[income_data+bx+2]
cmp ax,dx
jle no_swap

mov [income_data+bx],dx
mov [income_data+bx+2],ax
mov byte[swaper],1

no_swap:
add bx,2
cmp bx,28
jne loop1
cmp byte[swaper],1
je start

swap_start:
mov bx,0
swap:
mov ax,[income_data+bx]
mov [vul_fam+bx],ax
add bx,2
cmp bx,8
jbe swap

swap2_start:
mov bx,28
mov si,0

swap2:
mov ax,[income_data+bx]
mov [tax_fam+si],ax
sub bx,2
add si,2
cmp si,8
jbe swap2

last:
mov bx,0

l2:
mov ax,[tax_fam+bx]
sub ax,30
add [vul_fam+bx],ax
add bx,2
cmp bx,8
jbe l2

mov ax,0x4c00
int 0x21

income_data: dw 100,10,9,50,49,55,90,60,34,-50,34,-50,-50,300,139
tax_fam: dw 0,0,0,0,0
vul_fam: dw 0,0,0,0,0
swaper: db 0
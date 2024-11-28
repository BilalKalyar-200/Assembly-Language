[org 0x100]

jmp start

num: dw 9,8,7,6,5,4,3,32,2,1
num2: dw 1,2,3,4,5,2,3,4,5,6,7,5,2,8,5,3 ;16elemetns
swaper: db 0

bubble_sort:

push bp
;bp will be used as address of first element of array
;we pushed two things after address of first element (10 and address of return)

mov bp,sp
;sp points at the last things pushed into stack(its address)

push ax
push bx
push cx
push si

;as we know we have three things in stack after address of array (10,returning address,bp)
;so we will use +6 to go to that address where array is stored
mov bx,[bp+6]
mov cx,[bp+4]
dec cx
shl cx,1

l1:
mov si,0
mov byte[swaper],0

l2:
mov ax,[bx+si]
cmp ax,[bx+si+2]
jbe noswap

xchg ax,[bx+si+2]
mov [bx+si],ax
mov byte[swaper],1

noswap:
add si,2
cmp si,cx
jne l2

cmp byte[swaper],1
je l1

pop si
pop cx
pop bx
pop ax
pop bp
ret 4   ;it will remove three things from stack. The top thing would be the address of the line where we want to go back and other
;two will be parameters that we passed(address of array and number of elements)
;we wrote 4 bcz it removes 4bytes ->2 paramters
start:
mov ax,num
push ax
mov ax,10
push ax
call bubble_sort

mov ax,0x4c00
int 0x21
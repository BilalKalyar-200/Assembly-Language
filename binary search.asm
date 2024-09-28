[org 0x100]

start:
 mov bx,0
mov byte [swaper],0

l1:
mov al,[num+bx]
mov dl,[num+bx+1]
cmp ax,dx
jbe no_sort

mov [num+bx],dl
mov [num+bx+1],al
mov byte [swaper],1

no_sort:
add bx,1
cmp bx,6
jne l1

cmp byte [swaper],1
je start	;sorting done

;now searching

mov cl,3 ;to find
mov bx,3
mov si,3
cmp [num+bx],cl
jae left
l4:
cmp [num+bx],cl
je found
add bx,1
cmp bx,6
je end
jmp l4

left:
cmp cl,[num+si]
jbe left_founder
jmp end

left_founder:
cmp [num+si],cl
je found
sub si,1
jmp left_founder

found:

mov byte[founder],1
end:
mov ax,0x4c00
int 0x21
num: db 5,2,3,4,4,1,5
swaper: db 0
founder: db 0
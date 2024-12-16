;this program prints two rectangles and then find the max number in my roll no and then
;if shifting that number gives carry than it fills rectanlge two(red)
;otherwise it fills rectanlge 1
[org 0x100]
jmp start
rect_height: dw 6
rect_width: dw 12
rect1_height: dw 0
rect1_width: dw 0
maxx: dw 0
roll_no: dw 0647
clrscr:
mov ax,0xb800
mov es,ax
mov di,0
mov cx,2000
mov ax,0x0720
nxt_loc:
stosw
loop nxt_loc
ret

border1:    ;to print top/bottom border
push di
mov ah,[bp+8]   ;attribute
mov al,'='
mov cx,[bp+10]   ;widht of rectangle
l1:
stosw
loop l1
pop di
ret

border2:  ;to print left/right border
push di
mov ah,[bp+8]   ;attribute
mov al,'='
mov cx,[bp+12]   ;height of rectangle
l2:
mov [es:di],ax
add di,160
loop l2
pop di
ret 

prnt_reactangle:
push bp
mov bp,sp
mov ax,80
mul word[bp+6]
add ax,[bp+4]
shl ax,1
mov di,ax
mov ax,0xb800
mov es,ax
cld
call border1
mov ax,[bp+12]  ;adding height to print at bottom 
add word [bp+6],ax
mov ax,80
mul word[bp+6]
add ax,[bp+4]
shl ax,1
mov di,ax
call border1
mov ax,[bp+12]  ;removing height to get starting row
sub word [bp+6],ax
mov ax,80
mul word[bp+6]
add ax,[bp+4]
shl ax,1
mov di,ax
call border2

mov ax,[bp+10]  ;adding row to print at last column
add word [bp+4],ax
mov ax,80
mul word[bp+6]
add ax,[bp+4]
shl ax,1
mov di,ax
call border2

pop bp
ret 10

find_max:       ;to find max digit from roll no
push bp
mov bp,sp
mov ax,[roll_no]
mov bx,10
lop:
mov dx,0
div bx
cmp dx,[maxx]
jg swap
cmp ax,0
jne lop
jmp rett
swap:
mov [maxx],dx
cmp ax,0
jne lop
rett:
pop bp
ret 2

fill_with_one:
push bp
mov bp,sp
mov ax,80
mul word[bp+6]
add ax,[bp+4]
shl ax,1
mov di,ax
sub di,160  ;pharlo logic
push di ;for later user
mov ax,0xb800
mov es,ax
mov ah,[bp+8]
mov al,'1'
mov bx,[bp+12]
outer:
pop di
add di,160
push di
mov cx,[bp+10]
inner:
mov [es:di],ax
add di,2
loop inner
dec bx
cmp bx,0
jne outer
pop di
pop bp
ret 10

start:
call clrscr
mov bx,2
mov dx,0
mov ax,[rect_height]
div bx
push ax ;half height for rectangle 1
mov [rect1_height],ax
mov dx,0    
mov ax,[rect_width]
div bx
push ax ;half widht for rectangle 1
mov [rect1_width],ax

push word 02
mov ax,1    ;row
push ax
mov ax, 1   ;col
push ax
call prnt_reactangle


push word[rect_height]
push word[rect_width]
push word 04
mov ax,1   ;row
push ax
mov ax, 40   ;col
push ax
call prnt_reactangle

;find max from roll no
call find_max

mov ax,[maxx]
shr ax,1
jnc green_fill
red_fill:

sub word[rect_height],1      ;excluding a border
sub word[rect_width],1       ;excluding a border

push word[rect_height]
push word[rect_width]
push word 07    ;white  
mov ax,2   ;row
push ax
mov ax, 41   ;col
push ax
call fill_with_one
jmp enddd
green_fill:

sub word[rect1_height],1      ;excluding a border
sub word[rect1_width],1       ;excluding a border

push word[rect1_height]
push word[rect1_width]
push word 07    ;white  
mov ax,2   ;row
push ax
mov ax, 2   ;col
push ax
call fill_with_one
enddd:
mov al,01
int 0x10
mov ax,0x4c00
int 0x21
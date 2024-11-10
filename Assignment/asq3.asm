This program monitors sensor data represented as 16-bit
hexadecimal numbers, where each bit indicates an alert
state. The program includes a `count_ones` subroutine 
that counts active alerts (bits set to 1) in the sensor
data. The `categorize_alerts` subroutine then categorizes
these alerts based on their bit positions: bits 15-12 are
**Critical Alerts**, bits 11-8 are **Warning Alerts**,
and bits 7-0 are **Info Alerts**. Each category's count
is stored in labels such as `CriticalAlert`, `warning_alerts`,
and `info_alerts`. Finally, the program displays a message on 
the console showing the total alerts and their counts by category. 


[org 0x100]
jmp start
clrscr:
push es
push ax
push di
mov ax,0xb800
mov es,ax
mov di,0
ll:
mov word[es:di],0x0720
add di,2
cmp di,4000
jne ll
pop di
pop ax
pop es
ret
print: 
push bp
mov bp,sp
mov ax,0xb800
mov es,ax
mov ax,80
mul byte[bp+12]
add ax,[bp+10]
shl ax,1
mov di,ax
mov si, [bp+8]                ;loading msg
mov cx, [bp+4]              ;length of msg
mov ah,07
LLL:
mov al,[si]
mov [es:di],ax
add si,1
add di,2
loop LLL
mov si,[bp+6]   ;index
mov ax,[counter+si]     ;loads number
mov bx,10       ;base
mov cx,0    ;number of digits
l4:
mov dx,0
div bx
add dx,0x30
push dx
add cx,1
cmp ax,0
jne l4

pp:
pop dx
mov dh,07
mov [es:di],dx
add di,2
loop pp


pop bp
ret 4

count_bits:
push bp
mov bp,sp
mov bx,[bp+4]   ;address of number
mov ax,[bx]     ;gets the number in ax

and ah,0xF0     ;masking to get only first nibble ON
mov dx,0        ;number of one's
l1:
shl ah,1
jnc skip
add dx,1

skip:
cmp ah,0
jne l1
mov [counter],dx    ;number of ones in first nibble

mov ax,[bx]     ;gets the number in ax

and ah,0x0F     ;masking to get only second nibble ON
mov dx,0        ;number of one's
l2:
shr ah,1
jnc skip2
add dx,1

skip2:
cmp ah,0
jne l2
mov [counter+2],dx    ;number of ones in second nibble

;now for lower part
mov ax,[bx] ;loads number again
mov dx,0
l3:
shl al,1
jnc skip3
add dx,1
skip3:
cmp al,0
jne l3
mov [counter+4],dx    ;number of ones in lower part


;adding all
mov ax,[counter]
add ax,[counter+2]
add ax,[counter+4]
mov [counter+6],ax


pop bp
ret 2

start:
call clrscr
mov ax,arr
push ax
call count_bits

mov ax,1    ;row number
push ax
mov ax,0    ;column number
push ax

mov ax, msg1    ;to print all alerts
push ax
mov ax,6    ;index
push ax
push word 11    ;length
call print

mov ax,2    ;row number
push ax
mov ax,0    ;column number
push ax

mov ax, msg2    ;to prin't critical
push ax
mov ax,0    ;index
push ax
push word 17    ;length
call print

mov ax,3    ;row number
push ax
mov ax,0    ;column number
push ax

mov ax, msg3    ;to print warnings
push ax
mov ax,2    ;index
push ax
push word 16    ;length
call print

mov ax,4    ;row number
push ax
mov ax,0    ;column number
push ax

mov ax, msg4    ;to print info
push ax
mov ax,4    ;index
push ax
push word 13    ;length
call print

mov ax,0x4c00
int 0x21
arr: dw 0x0646
counter: dw 0,0,0,0
msg1: db 'All alerts: '
msg2: db 'Critical alerts: ' 
msg3: db 'warning alerts: '
msg4: db 'info alerts: '
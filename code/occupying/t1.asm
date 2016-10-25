.data
ARRAY dw 23,36,2,100,32000,54,0
ZERO dw ?
.code
start:
mov ax,@data
mov ds,ax
mov bx,offset ARRAY
mov [bx+14],0
mov bx,offset ARRAY[12]
mov [bx+2],0
end start

.model small
.data
    splited db 4 dup(?)
.code 
start:
    mov ax, @data
    mov ds, ax

    call split
    
    mov al, splited
    mov bl, splited + 1
    mov cl, splited + 2
    mov dl, splited + 3

    mov ah,4ch
    int 21h

split proc
    push dx
    push bx
    push cx

    mov bx, offset splited
    mov cx,4

    mov dx,ax
    and dx, 1111b
    mov [bx],dl

    ror ax,cl
    mov dx,ax
    and dx, 1111b
    mov [bx+1],dl

    ror ax,cl
    mov dx,ax
    and dx, 1111b
    mov [bx+2],dl

    ror ax,cl
    mov dx,ax
    and dx, 1111b
    mov [bx+3],dl
    
    pop cx
    pop bx
    pop dx
    ret
split endp

end start
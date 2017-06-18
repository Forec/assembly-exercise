;15、试编写一个汇编语言程序，求出首地址为 DATA 的 100D 字数组中的最小偶数，并把它存放在 AX 中。
.model small
.data
    data dw 10,9,8,7,6,5,4,3,2,1,90 dup(60)
.code
    start:
    mov ax,@data
    mov ds,ax
        
        call mineven

    mov ah,4ch
    int 21h

    mineven proc
        push bx
        push cx
        push dx
        push si


        mov bx,offset data
        mov si,0
        mov cx,100
        mov ax,[bx][si]

        checker:
            mov dx,[bx][si]
            test dx,1b
            jnz continue;check if even

            cmp ax,dx
            jle continue

            mov ax,dx

            continue:
            add si,2
        loop checker

        pop si
        pop dx
        pop cx
        pop bx

        ret
    mineven endp
end start
;假设有二十个无符号字存放在以 Buffer 为开始的缓冲区中，编写一个程序把它们从低到高排序。
.model small
.data
    buffer dw 1,2,10,3,4,5,6,7,20,8,9,11,12,13,14,15,16,17,18,19
.code
    start:
        mov ax,@data
        mov ds,ax

        mov bx, offset buffer
        call sortbuffer

        mov ah,4ch
        int 21h
    
    sortbuffer proc
        push bx
        push dx
        push cx
        push si

        lea bx, buffer
        mov si,0
        mov cx,19

        outerloop:
            push cx
            push si
            innerloop:
                mov dx,[bx][si]
                cmp dx,[bx+si+2]
                ja exchange
                jmp noexchange
                exchange:
                    xchg dx,[bx+si+2]
                    mov [bx+si],dx
                noexchange:
                add si,2
            loop innerloop
            pop si
            pop cx
            add si,2
        loop outerloop

        pop si
        pop cx
        pop dx
        pop bx
        ret
    sortbuffer endp
    end start
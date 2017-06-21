;19、从键盘输入一系列以 $ 为结束符的字符串，然后对其中的非数字字符计数，并显示出计数结果。
.model small
.data
    strings db '1234fdsa56fdsafdsa7fdsa890$'
.code
    start:
        mov ax,@data
        mov ds,ax

        call counter

        mov ah,4ch
        int 21h

        counter proc

            push ax
            push bx
            push dx
            push si

            mov bx,offset strings
            mov si,0

            mov ax,0

            startcount:
                mov dl,[bx][si]
                cmp dl, '0'
                jl nextloop
                cmp dl,'9'
                jg nextloop
                inc ax

                nextloop:
                cmp dl,'$'
                je display
                inc si
            jmp startcount
            
            display:
                mov dx,10
                div dl
                add al,'0'
                add ah,'0'
                push ax
                mov dl,al
                mov ah,02h
                int 21h
                pop ax
                mov dl,ah
                mov ah,02h
                int 21h
            
            pop si
            pop dx
            pop bx
            pop ax
            ret
        counter endp
    end start

                
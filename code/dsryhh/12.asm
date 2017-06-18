;12、试编写一程序，要求比较两个字符串 STRING1 和 STRING2 所含字符是否完全相同，若相同则显示 MATCH，若不相同则显示 NO MATCH。
.model small
.data
    STRING1 db 'hello world!',0
    STRING2 db 'hello china!',0
    matchString db 'MATCH$'
    nomatchString db 'NO MATCH$'
.code
    start:
        mov ax,@data
        mov ds,ax
        
        call compare

        mov ah,4ch
        int 21h
    
    compare proc
        push ax
        push bx
        push dx
        push si

        mov si,0

        comstart:
        mov bx,offset STRING1
        mov dl,[bx][si]
        mov bx,offset STRING2

        cmp dl, [bx][si]
        jne nomatch

        cmp dl, 0
        je match

        inc si
        jmp comstart

        nomatch:
            mov dx,offset nomatchString
            mov ah,09h
            int 21h
            jmp funcreturn

        match:
            mov dx,offset matchString
            mov ah,09h
            int 21h
            jmp funcreturn
        funcreturn:
        pop si
        pop dx
        pop bx
        pop ax

        ret
    compare endp

end start
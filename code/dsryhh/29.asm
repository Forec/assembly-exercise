;29、试编写一程序，要求比较数组 ARRAY中 的三个 16 位补码数，并根据比较结果在终端上显示如下信息：
.model small
.data
    array dw -2,2,-2
.code
    start:
        mov ax, @data
        mov ds,ax

        call compAndDisp

        mov ah,4ch
        int 21h
    
    compAndDisp proc
        push ax
        push dx

        mov ax,0
        mov dx,array
        
        cmp dx,array + 2
        jne cmp2
        inc ax

        cmp2:
        cmp dx,array + 4
        jne cmp3
        inc ax

        cmp3:
        mov dx,array + 2
        cmp dx,array + 4
        jne cmpend
        inc ax

        cmpend:
        cmp ax,0
        je disp0
        cmp ax,1
        je disp1
        jmp disp2

        disp0:
        mov dx,'0'
        mov ah,02h
        int 21h
        jmp procend
        
        disp1:
        mov dx,'1'
        mov ah,02h
        int 21h
        jmp procend

        disp2:
        mov dx,'2'
        mov ah,02h
        int 21h
        jmp procend

        procend:
        pop dx
        pop ax
        ret
    compAndDisp endp
end start
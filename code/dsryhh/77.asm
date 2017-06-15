;version control: the latest version can been seen at https://github.com/DSRYhh/SIMS-Assembly/blob/master/31.asm
data segment
    STUNAME DB 20 DUP(10 DUP('$'));each name has 10 bytes
    CLASS DB 20 DUP('$');each class has 1 byte
    STUID DB 20 DUP(10 DUP('$'));each id has 10 bytes
    SCORE DB 20 DUP(0,0);each score has 2 bytes
    COUNT DB 0;count of the student list
    SCORESEGMENT DB 5 DUP(0);fail,60~70,70~80,80~90,90~100
    DISPLAYORDER DB 20 DUP(0)

    RecordHint DB '---Student info input---',0dh,0ah,'$'
    RecordFinishHint DB '---Student info input complete---',0dh,0ah,'$'
    InputNumHint DB 'Input the number of students',0dh,0ah,'$'
    InputNameHint DB 'Input the name of students',0dh,0ah,'$'
    InputClassHint DB 'Input the class of students',0dh,0ah,'$'
    InputIdHint DB 'Input the id of students',0dh,0ah,'$'
    InputScoreHint DB 'Input the score of students. Example: 70.0',0dh,0ah,'$'
    NewLine DB 0dh,0ah,'$'
    ScoreSegmentLevelHint DB '-E- -D- -C- -B- -A-',0dh,0ah,'$'

    AppName DB '-----Student Information Management System-----',0dh,0ah,'$'
    Help DB '-r Register new student',0dh,0ah,
            '-d Display students list (ordered by score)',0dh,0ah,
            '-a Average score',0dh,0ah,
            '-n The number of each segments',0dh,0ah,
            '-h Help',0dh,0ah,
            '-q Exit system',0dh,0ah,'$'

    ArgumentExceptionHint DB 'Illegal argument. Try again.',0dh,0ah,'$'

data ends
stack segment stack
    DW 100h dup(?)
stack ends
code segment
    assume cs:code,ds:data,ss:stack
    main proc
    start:
        ;----clear all register
            xor ax,ax
            xor bx,bx
            xor cx,cx
            xor dx,dx
            xor si,si
            xor di,di

        mov ax,data
        mov ds,ax;init ds
        
        call dispappname
        call disphelp

        commandReadIn:
        call disphyphen

        mov ah,01h
        int 21h;READ CHARACTER FROM STANDARD INPUT
        ;command store in AL now
        
        call dispnewline

        cmp al,'r';switch
        je recordCommand
        cmp al,'d'
        je displayCommand
        cmp al,'a'
        je averageCommand
        cmp al,'n'
        je numberCommand
        cmp al,'h'
        je helpCommand
        cmp al,'q'
        je exit
        call disphelp
        jmp commandReadIn;input illegal parameter

        recordCommand:
            call recordf
        jmp commandReadIn

        displayCommand:
            call dispinorder
        jmp commandReadIn

        averageCommand:
            call averagescore
        jmp commandReadIn

        numberCommand:
            call statisticsegment
        jmp commandReadIn

        helpCommand:
            call disphelp
        jmp commandReadIn

        exit:
        mov ah,4ch
        int 21h
    main endp

    recordf proc
        push dx
        push ax
        push bx
        push cx

            lea dx,RecordHint
            mov ah,09h
            int 21h;output hint

            recordfInputNumBegin:
            lea dx,InputNumHint
            mov ah,09h
            int 21h;output hint
            
            mov ah,01h
            int 21h;READ CHARACTER FROM STANDARD INPUT
            call dispnewline
            ;number store in AL now
            ;paramater vaildation
            cmp al,'0'
            jl recordfInputNumError
            cmp al,'9'
            jg recordfInputNumError
            jmp recordfInputNumRight
            recordfInputNumError:
            call dispwrongargumenthint
            jmp recordfInputNumBegin
            recordfInputNumRight:
            sub al,30h;convert ASCII code to number
            xor cx,cx;set cx to zero
            mov cl,al


            onestu:
                call readname
                call dispnewline

                call readclass
                call dispnewline

                call readstuid
                call dispnewline
                
                call readscore
                call dispnewline

                inc COUNT
            dec cx
            jne onestu

            lea dx,RecordFinishHint
            mov ah,09h
            int 21h;output hint

        pop cx
        pop bx
        pop ax
        pop dx
        ret
    recordf endp

    dispinorder proc
        push cx
        push dx
        push ax
        push dx
        push si
            xor cx,cx
            
            mov cx,0
            mov cl,COUNT
            call sortbyscore
            mov bx,offset DISPLAYORDER
            mov si,0
            dispinorderLoop:
                ;mov dl,cl
                ;dec dl;index begin from 0
                mov dx,0
                mov dl,[bx][si]
                call dispitem

                inc si
            loop dispinorderLoop
        
        pop si
        pop dx
        pop ax
        pop dx
        pop cx
        ret
    dispinorder endp

    readname proc
        ;input name begin
        push cx
        push dx
        push ax
        push si
        push bx
            lea dx,InputNameHint
            mov ah,09h
            int 21h;output hint
            
            mov dl,10
            mov al,COUNT
            mul dl;ax = count * 10. offset of name
            mov si,ax
            lea bx,STUNAME
            mov cx,0
            inputname:
                mov ah,01h
                int 21h;READ CHARACTER FROM STANDARD INPUT
                cmp al,0dh
                je inputnamefinish
                cmp cx,9d
                je inputnamefinish

                mov [bx][si],al

                inc si
                inc cx
            jmp inputname
            inputnamefinish:
            mov [bx][si],'$'
        pop bx
        pop si
        pop ax
        pop dx
        pop cx
        ret
    readname endp

    readclass proc
        ;input class begin
        push dx
        push ax
        push si
        push bx
        
            lea dx,InputClassHint
            mov ah,09h
            int 21h;output hint

            mov ax,0
            mov al,COUNT
            mov si,ax;COUNT in al
            lea bx,class

            mov ah,01h
            int 21h;READ CHARACTER FROM STANDARD INPUT

            sub al,30h;convert ASCII code to number
            mov [bx][si],al
        
        pop bx
        pop si
        pop ax
        pop dx
        ret
    readclass endp

    readstuid proc
        ;input stuid begin
        push ax
        push bx
        push cx
        push dx
        push si
            lea dx,InputIdHint
            mov ah,09h
            int 21h;output hint

            mov dl,10
            mov ax,0
            mov al,COUNT
            mul dl;ax = count * 10. offset of name
            mov si,ax
            lea bx,STUID
            mov cx,0
            inputid:
                mov ah,01h
                int 21h;READ CHARACTER FROM STANDARD INPUT
                cmp al,0dh
                je inputidfinish
                cmp cx,9d
                je inputidfinish

                ;sub al,30h
                mov [bx][si],al

                inc si
                inc cx
            jmp inputid
            inputidfinish:
            mov [bx][si],'$'
        pop si
        pop dx
        pop cx
        pop bx
        pop ax
        ret
    readstuid endp

    readscore proc
        ;input score begin
        push ax
        push bx
        push dx
        push si
            lea dx,InputScoreHint
            mov ah,09h
            int 21h;output hint

            push dx
            xor dx,dx
            mov dl,COUNT
            mov si,dx
            pop dx
            add si,si;si = count * 2
            lea bx,SCORE

            mov ah,01h
            int 21h;READ CHARACTER FROM STANDARD INPUT
            sub al,30h;convert ASCII code to number
            mov dl,10
            mul dl
            mov dx,ax;ten-digit in DX.

            mov ah,01h
            int 21h;READ CHARACTER FROM STANDARD INPUT
            sub al,30h;convert ASCII code to number
            add dl,al;score < 100, so dh = 00h

            mov [bx][si],dl;integer part

            mov ah,01h
            int 21h;READ CHARACTER FROM STANDARD INPUT
            cmp al,'.'
            jne inputscorefinish
            mov ah,01h
            int 21h;READ CHARACTER FROM STANDARD INPUT
            sub al,30h
            mov 1h[bx][si],al

            inputscorefinish:
        pop si
        pop dx
        pop bx
        pop ax
        ret
    readscore endp

    dispitem proc
        ;input: DL: index

        call dispitemname
        call dispitemclass
        call dispitemstuid
        call dispitemscore
        
        call dispnewline

        ret
    dispitem endp

    dispitemname proc
        ;display name
        ;input DX index
        push dx
        push bx
        push ax
        push si
            lea bx,ds:STUNAME
            mov al,10
            mul dl
            mov si,ax

            lea dx,ds:[bx][si]
            mov ah,09h
            int 21h;output name

            call dispwhitespace
        pop si
        pop ax
        pop bx
        pop dx
        ret
    dispitemname endp

    dispitemclass proc
        ;display class
        push dx
        push bx
        push si
        push ax
            lea bx,ds:CLASS
            mov si,dx
            mov dl,ds:[bx][si]
            add dl,30h;convert number to ASCII code
            mov ah,02h
            int 21h

            call dispwhitespace
        pop ax
        pop si
        pop bx
        pop dx
        ret
    dispitemclass endp

    dispitemstuid proc
        ;display stuid
        push dx
        push bx
        push ax
        push si
            lea bx,ds:STUID
            mov al,10
            mul dl
            mov si,dx

            lea dx,ds:[bx][si]
            mov ah,09h
            int 21h;output id

            call dispwhitespace
        pop si
        pop ax
        pop bx
        pop dx
        ret
    dispitemstuid endp

    dispitemscore proc
        ;display score
        ;input DX index
        push dx
        push bx
        push si
        push ax

            lea bx,ds:SCORE
            mov si,dx
            add si,si;SI = DL * 2

            mov ax,0
            mov al,ds:[bx][si]
            mov dl,10
            div dl;DL = AX / 10, AL = integer part of score

            push ax;02h system interrupt will use al as return value
            mov dl,al
            add dl,30h;convert number to ASCII code
            mov ah,02h
            int 21h
            pop ax

            push ax;02h system interrupt will use al as return value
            mov dl,ah
            add dl,30h;convert number to ASCII code
            mov ah,02h
            int 21h
            pop ax

            call dispdot

            push ax
            mov dl,ds:1h[bx][si]
            add dl,30h;convert number to ASCII code
            mov ah,02h
            int 21h
            pop ax

            call dispwhitespace

        pop ax
        pop si
        pop bx
        pop dx
        ret
    dispitemscore endp

    dispwhitespace proc
        push dx
        push ax
            mov dl,' '
            mov ah,02h
            int 21h;display a withespace
        pop ax
        pop dx

        ret
    dispwhitespace endp

    dispnewline proc
        push ax
        push dx
            lea dx,NewLine
            mov ah,09h
            int 21h;output hint
        pop dx
        pop ax
        ret
    dispnewline endp

    dispwrongargumenthint proc
        push ax
        push dx
            lea dx,ArgumentExceptionHint
            mov ah,09h
            int 21h;output hint
        pop dx
        pop ax
        ret
    dispwrongargumenthint endp

    disphelp proc
        push ax
        push dx
            lea dx,Help
            mov ah,09h
            int 21h;output hint

            call dispnewline
        pop dx
        pop ax
        ret
    disphelp endp

    dispappname proc
        push ax
        push dx
            lea dx,AppName
            mov ah,09h
            int 21h;output hint
        pop dx
        pop ax
        ret
    dispappname endp

    dispsegmentlevelhint proc
        push ax
        push dx
            lea dx,ScoreSegmentLevelHint
            mov ah,09h
            int 21h;output hint
        pop dx
        pop ax
        ret
    dispsegmentlevelhint endp

    disphyphen proc
        push dx
        push ax
            mov dl,'-'
            mov ah,02h
            int 21h;display a withespace
        pop ax
        pop dx

        ret
    disphyphen endp

    dispdot proc
        push dx
        push ax
            mov dl,'.'
            mov ah,02h
            int 21h;display a dot
        pop ax
        pop dx

        ret
    dispdot endp

    disptabs proc
        push dx
        push ax
            mov dl,09h
            mov ah,02h
            int 21h;display a tab
        pop ax
        pop dx

        ret
    disptabs endp

    averagescore proc
        push cx
        push dx
            mov cx,0

            ;integer part
            mov si,0
            call scoresum;return value in AX
            mov dl,COUNT
            div dl;result store in AX
            push ax
            mov al,ah;Handle the remainder
            mov dx,10
            mul dl;remainder * 10
            mov dl,COUNT
            div dl;remainder * 10 / COUNT = decimal part
            mov dl,al;dl: decimal part
            pop ax
            mov dh,al;dh: integer part
            push dx

                ;decimal part
                mov si,1
                call scoresum
                mov dl,COUNT
                div dl;decimal part in AL

            pop dx

            add dl,al;result in dx
            call dispfloat
            call dispnewline

        pop cx
        pop dx
        ret
    averagescore endp

    scoresum proc
        ;PARAM SI: SI = 0, integer part; SI = 1, decimal part
        ;RETURN AX: sum
        push si
        push cx
        push dx
            mov cx,0
            mov cl,COUNT
            mov ax,0

            mov bx, offset SCORE

            scoresumloopallcount:
                mov dx,0
                mov dl,[bx][si]
                add ax,dx

                add si,2h
            loop scoresumloopallcount
        pop dx
        pop cx
        pop si
        ret
    scoresum endp

    dispfloat proc
        ;input param: dx  float to be showed
        push dx
            mov dl,dh
            mov dh,0
            call dispbyte
        pop dx
        call dispdot
        
        add dl,30h
        call dispchar

        ret
    dispfloat endp

    dispbyte proc
        ;input param: dl
        push dx
        push ax
            mov dh,0
            mov ax,dx
            mov dx,100
            div dl
            mov dl,al
            add dl,30h
            call dispchar

            mov al,ah
            mov ah,0
            mov dx,10
            div dl
            mov dl,al
            add dl,30h
            call dispchar

            mov al,ah
            mov ah,0
            mov dx,1
            div dl
            mov dl,al
            add dl,30h
            call dispchar

        pop ax
        pop dx
        ret
    dispbyte endp

    dispchar proc
        ;input char(ASCII code) in dl
        push dx
        push ax
            mov ah,02h
            int 21h;display a withespace
        pop ax
        pop dx

        ret
    dispchar endp

    statisticsegment proc
        push bx
        push cx
        push si
            mov cx,0
            mov cl,COUNT
            
            cmp cl,0
            je statisticsegmentexit

            mov bx,offset SCORE
            mov si,0

            statisticsegmentloop:
                mov dx,0
                mov dl,[bx][si]
                call scoresegmentchecker

                add si,2
            loop statisticsegmentloop

            statisticsegmentexit:
            call dispscoresegment
        pop si
        pop cx
        pop bx
        ret
    statisticsegment endp

    scoresegmentchecker proc
        ;input param DL: integer part of score
        pushf
            cmp dl,90d
            jge scoresegmentchecker90
            cmp dl,80d
            jge scoresegmentchecker80
            cmp dl,70d
            jge scoresegmentchecker70
            cmp dl,60d
            jge scoresegmentchecker60
            jmp scoresegmentcheckerfailed

            scoresegmentchecker90:
                inc SCORESEGMENT + 4
                jmp scoresegmentcheckerexit
            scoresegmentchecker80:
                inc SCORESEGMENT + 3
                jmp scoresegmentcheckerexit
            scoresegmentchecker70:
                inc SCORESEGMENT + 2
                jmp scoresegmentcheckerexit
            scoresegmentchecker60:
                inc SCORESEGMENT + 1
                jmp scoresegmentcheckerexit
            scoresegmentcheckerfailed:
                inc SCORESEGMENT
                jmp scoresegmentcheckerexit
            scoresegmentcheckerexit:

        popf
        ret
    scoresegmentchecker endp

    dispscoresegment proc
        push cx
        push bx
        push si
        push dx
            mov bx,offset SCORESEGMENT
            mov si,0
            mov cx,5
            call dispsegmentlevelhint
            dispscoresegmentloop:
                mov dl,[bx][si]
                call dispbyte
                call dispwhitespace
                inc si
            loop dispscoresegmentloop
            call dispnewline
        pop dx
        pop si
        pop bx
        pop cx
        ret
    dispscoresegment endp

    sortbyscore proc
        push ax
        push cx
        push bx
        push si

            call initorder

            mov bx,offset DISPLAYORDER
            mov si,0
            mov cx,0
            mov cl,COUNT

            cmp cl,1
            je sortbyscoreexit;if COUNT == 1 then return

            dec cl;loop COUNT - 1 times
            sortbyscoreloopouter:
                push cx
                mov cx,0
                mov cl,COUNT
                dec cl;loop COUNT - 1 times
                mov si,0
                sortbyscoreloopinner:
                    ;TODO
                    mov dl,[bx][si];get current index
                    call getscorewithindex
                    mov ax,dx
                    mov dl,1[bx][si];get next index
                    call getscorewithindex
                    cmp ax,dx
                    jl sortbyscoreexchange
                    jmp sortbyscorekeep
                    sortbyscoreexchange:
                    mov dl,[bx][si]
                    xchg dl,1[bx][si]
                    mov [bx][si],dl
                    sortbyscorekeep:
                    inc si
                loop sortbyscoreloopinner
                pop cx
            loop sortbyscoreloopouter

        sortbyscoreexit:
        pop si
        pop bx
        pop cx
        pop ax
        ret
    sortbyscore endp

    getscorewithindex proc
        ;input DL: index of item
        ;return DX: score of item
        push bx
        push si
            mov bx,offset SCORE
            mov dh,0
            add dx,dx
            mov si,dx;SI = 2 * DL
            mov dx,[bx][si];Byte order
            xchg dl,dh
        pop si
        pop bx
        ret
    getscorewithindex endp

    initorder proc
        push cx
        push bx
        push si
            ;init order
            mov cx,0
            mov cl,COUNT

            mov bx,offset DISPLAYORDER
            mov si,0

            sortbyscoreloop:
                mov [bx][si],cl
                dec BYTE PTR [bx][si]
                inc si
            loop sortbyscoreloop
        pop si
        pop bx
        pop cx
        ret
    initorder endp

code ends
end start
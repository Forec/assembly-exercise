TITLE T5_YWT

DATA    SEGMENT
        LNAME       DB  30 DUP(?)
        ADDRESS     DB  30 DUP(?)
        CITY        DB  15 DUP(?)
        CODE_LIST   DB  1, 7, 8, 3, 2     
        ;;(3)
        CODE_LENGTH EQU $ - CODE_LIST
        VERIFY      DB  CODE_LENGTH
ENDS

CODE    SEGMENT
        ASSUME CS:CODE, DS:DATA 
    
START:  MOV AX, DATA
        MOV DS, AX
    
        ;; (1)
        MOV AX, WORD PTR LNAME
    
        ;; (2)
        MOV  SI, WORD PTR CODE_LIST
    
        ;; FINISH
        MOV AX, 4C00H
        INT 21H
    
ENDS
        END START
    
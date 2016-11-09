;; Created by Ywt.
;; Date: 11/03/2016  

TITLE 4.16_YWT

DATA    SEGMENT
    BUFF    DW  50 DUP(-1)
            DW  50 DUP(0)
            DW  100 DUP(1)        
    N1      DB  ?
    N2      DB  ?
    N3      DB  200    
ENDS

CODE    SEGMENT
        ASSUME CS:CODE, DS:DATA 
    
START:  MOV AX, DATA
        MOV DS, AX
        
        ;; DH= NUM OF POSITIVE DL = NUM OF ZERO 
        MOV CX, 200
        LEA SI, BUFF
        MOV DX, 0
        SUB SI, 2 
               
CHECK:  ADD SI, 2
        CMP [SI],0
        JNZ NZ
        INC DL
        LOOP CHECK
        JMP ASSIGN        
NZ:     JG NGE
        INC DH   
        LOOP CHECK
        JMP ASSIGN         
NGE:    LOOP CHECK
        
        ;; STORE DATA TO RAM
ASSIGN: MOV N1, DH
        MOV N2, DL
        SUB N3, DH
        SUB N3, DL  
    
        ;; FINISH
        MOV AX, 4C00H
        INT 21H
    
ENDS
        END START
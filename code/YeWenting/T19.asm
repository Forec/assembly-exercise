;; Created by Ywt.
;; Date: 11/21/2016
;;
;; LOOP: READ CHAR
;; JUDGE IF IT'S A NUMBER  
;; BX-> NUM OF NON-NUMBER

TITLE   T19_YWT

DATA SEGMENT
    ARRAY DB 10 DUP(?)
ENDS

CODE	SEGMENT
	    ASSUME CS:CODE DS:DATA

START:	XOR CX, CX
        MOV AX, DATA
        MOV DS, AX
        
READ:   MOV AH, 1
        INT 21H
        CMP AL, 24H
        JE  RDEND
        CMP AL, 30H
        JB  READ
        CMP AL, 39H
        JA  READ
        INC CX
        JMP READ
        
        ;; STORE CX IN BASE 10 (BX->LEN AX->NUM CX->10) 
RDEND:  XOR BX, BX
        MOV AX, CX
        MOV CL, 10
TRANS:  DIV CL
        ADD AH, '0'
        MOV ARRAY[BX], AH
        CBW
        INC BX
        CMP AX, 0
        JNZ TRANS
        
        ;; PRINT 'ENTER'
        MOV AH, 2      
        MOV DL, 0AH
        INT 21H
        MOV DL, 0DH    
        INT 21H
        
        ;; PRINT THE NUMBER
PRINT:  DEC BX
        MOV DL, ARRAY[BX]
        INT 21H
        JNZ PRINT 
         
EXIT:   MOV AH, 4CH
        INT 21H
ENDS
END START
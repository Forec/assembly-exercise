;; Created by Ywt.
;; Date: 12/4/2016  

TITLE   T29_YWT

DATA	SEGMENT
    ARRAY   DW  1, -1, -1   
ENDS

CODE	SEGMENT
	    ASSUME CS:CODE, DS:DATA

START:	     
        MOV AX, DATA
        MOV DS, AX 
        
        ;; AX->ARRAY[0] BX->ARRAY[1] DL->ANS
        MOV AX, ARRAY[0]
        MOV BX, ARRAY[2]
        CMP AX, BX
        JZ  S0E1
        JMP S0NE1
S0E1:   CMP BX, ARRAY[2 * 2]
        JE  ANS2
        JMP ANS1
S0NE1:  CMP AX, ARRAY[2 * 2]
        JE  ANS1
        CMP BX, ARRAY[2 * 2]
        JNE ANS0
        JMP ANS1

ANS0:   MOV DL, 30H
        JMP PRINT
ANS1:   MOV DL, 31H
        JMP PRINT
ANS2:   MOV DL, 32H
        JMP PRINT 
        
PRINT:  MOV AH, 02H
        INT 21H                 
	    ;; FINISH
	    MOV AH, 4CH
	    INT 21H 
	   

ENDS
END START


;; Created by Ywt.
;; Date: 12/4/2016  

TITLE   T27_YWT

DATA	SEGMENT
    A   DW  1, 2, 3, 4, 8, 10 DUP(?)
    B   DW  0, 1, 4, 5, 9, 15 DUP(?)
    C   DW  15 DUP(?) 
ENDS

CODE	SEGMENT
	    ASSUME CS:CODE, DS:DATA

START:	     
        MOV AX, DATA
        MOV DS, AX
        
        ;; SI->A DI->B BX->C         
        MOV BX, 0
        MOV SI, 0
LOOP1:  MOV AX, A[SI]
        MOV DI, -1
LOOP2:  INC DI
        CMP DI, 20
        JZ  NO          ;; NO FOUND
        CMP AX, B[DI]
        JNZ LOOP2
        JMP YES         ;; FOUND
YES:    MOV C[BX], AX
        INC BX
NO:     INC SI
        CMP SI, 15
        JE DONE
        JMP LOOP1
        
	    ;; FINISH
DONE:   MOV AH, 4CH
	    INT 21H 
	   

ENDS
END START


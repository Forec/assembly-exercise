;; Created by Ywt.
;; Date: /2016  

TITLE   T_YWT

DATA	SEGMENT
    A   DW  1
    B   DW  1 
ENDS

CODE	SEGMENT
	    ASSUME CS:CODE, DS:DATA

START:	     
        MOV AX, DATA
        MOV DS, AX
        
        ;; AX->A BX->B
        MOV AX, A
        MOV BX, B
        TEST AX, 0001H
        JZ  AE
        JMP AO
AE:     TEST BX, 0001H
        JZ  DONE
        JMP AEBO
AO:     TEST BX, 0001H
        JZ  DONE
        JMP AOBO

AOBO:   ADD AX, 1
        MOV A, AX
        ADD BX, 1
        MOV B, BX
        JMP DONE
AEBO:   XCHG AX, BX
        MOV A, AX
        MOV B, BX
DONE:                
	    ;; FINISH
	    MOV AH, 4CH
	    INT 21H 
	   

ENDS
END START


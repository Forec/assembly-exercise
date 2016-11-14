;; Created by Ywt.
;; Date: 11/03/2016  

TITLE   T15_YWT

DATA	SEGMENT   
    ;; The mininum is 2, while there is a smaller odd num. 1
    DW 4, 1, 2, 97 DUP (4)
ENDS

CODE	SEGMENT
	    ASSUME CS:CODE, DS:DATA, SS:STACK

START:	MOV AX, DATA
	    MOV DS, AX
        MOV CX, 100
        MOV DI, 0
        MOV AX, 07FFFH
        
FIND:   TEST [DI], 1
        JNZ NEXT
        CMP AX, [DI]
        JLE NEXT
        MOV AX, [DI]
NEXT:   ADD DI, 2
        LOOP FIND
        
	    ;; FINISH
	    MOV AH, 4CH
	    INT 21H

ENDS
END START
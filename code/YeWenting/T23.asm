;; Created by Ywt.
;; Date: 11/22/2016  

TITLE   T23_YWT

DATA	SEGMENT
    M   DW  1, -1, 2, 3, 6 DUP (0), ?, ?
    N   EQU 10
ENDS

CODE	SEGMENT
	    ASSUME CS:CODE, DS:DATA

START:	MOV AX, DATA
	    MOV DS, AX
	              
	    ;; BX->INDEX CX->MAX_ABS 
	    ;; DI->MAX_INDEX
	    ;; DX->MAX_NUM
	    XOR BX, BX
	    XOR CX, CX
LOOP1:  MOV AX, M[BX]
        TEST AX, 8000H
        JZ  ABS
        XOR AX, 0FFFFH
        INC AX
ABS:    CMP AX, CX
        JNA NEXT
        MOV CX, AX
        MOV DI, BX
        MOV DX, M[BX]
NEXT:   ADD BX, 2
        CMP BX, 2*N
        JNZ LOOP1
        
END:    MOV M[2*N], DX
        MOV M[2*N+2], DI

	    ;; FINISH
	    MOV AH, 4CH
	    INT 21H

ENDS
END START
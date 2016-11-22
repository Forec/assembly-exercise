;; Created by Ywt.
;; Date: 11/22/2016  

TITLE   T21_YWT

DATA	SEGMENT
    STRING  DB  99 DUP ('A'), '1'
ENDS

CODE	SEGMENT
	    ASSUME CS:CODE, DS:DATA

START:	MOV AX, DATA
	    MOV DS, AX
	    XOR CL, CL	    
	    XOR BX, BX
	    
LOOP1:  CMP STRING[BX], 30H
        JB  NON
        CMP STRING[BX], 39H
        JA  NON
        OR  CL, 10H
        JMP END
NON:    INC BX
        CMP BX, 100
        JZ  END
        JMP LOOP1        

	    ;; FINISH
END:    MOV AH, 4CH
	    INT 21H

ENDS
END START
;; Created by Ywt.
;; Date: 12/3/2016  

TITLE   T25_YWT

DATA	SEGMENT
    MEM DB 4 DUP('?')
ENDS

CODE	SEGMENT
	    ASSUME CS:CODE, DS:DATA

START:	     
        MOV AX, DATA
        MOV DS, AX 
        
        MOV AX, 2A49H
        MOV SI, 0
        MOV CL, 4
        
LOOP1:  MOV BX, 000FH
        AND BX, AX
        CMP BX, 0AH
        JB ASCII
        ADD BX, 'A' - 3AH
ASCII:  ADD BX, 30H
        SHR AX, CL
        MOV MEM[SI], BL
        INC SI
        CMP SI, 5
        JNE LOOP1
                
	    ;; FINISH
	    MOV AH, 4CH
	    INT 21H 
	   

ENDS
END START


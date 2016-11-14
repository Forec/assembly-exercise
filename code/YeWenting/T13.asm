;; Created by Ywt.
;; Date: 11/03/2016  

TITLE   T13_YWT

DATA	SEGMENT
ENDS

CODE	SEGMENT
	    ASSUME CS:CODE, DS:DATA, SS:STACK

START:	MOV AX, DATA
	    MOV DS, AX
        
        ;; READ N TO CX
        MOV AH, 01H
        INT 21H
        SUB AL, 30H
        XOR CX, CX
        MOV CL, AL
        MOV AH, 02H
        MOV DL, 07H
        
        ;; RING
RING:   INT 21H
        LOOP RING
                
	    ;; FINISH
	    MOV AH, 4CH
	    INT 21H

ENDS
END START


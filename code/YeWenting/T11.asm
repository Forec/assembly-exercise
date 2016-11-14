;; Created by Ywt.
;; Date: 11/03/2016  

TITLE   T11_YWT

DATA	SEGMENT
ENDS

CODE	SEGMENT
	ASSUME CS:CODE, DS:DATA, SS:STACK

START:	;; SET INITIAL VALUE
        MOV AX, 0ABCDH   
        MOV BL, 0FH
        MOV CL, 04H
        MOV DL, 0F0H
        
        ;; TRANSFER
        AND BL, AH
        AND DL, AL
        SHR DL, CL
        AND AH, 0F0H
        SHR AH, CL
        XCHG DL, CL
        MOV DL, 0FH
        AND DL, AL
        MOV AL, AH

        ;; FINISH
        MOV AH, 4C0H
        MOV AL, AL
        INT 21H
    
ENDS
END START


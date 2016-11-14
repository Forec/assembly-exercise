;; Created by Ywt.
;; Date: 11/13/2016  

TITLE T

DATA	SEGMENT
ENDS

CODE	SEGMENT
	ASSUME CS:CODE, DS:DATA, SS:STACK

START:  MOV AX, DATA
        MOV DS, AX
        
        MOV AH, 01
        INT 21H
        SUB AL, 32
        MOV DL, AL
        MOV AH, 02
        INT 21H

        ;; FINISH
        MOV AX, 4C00H
        INT 21H
    
ENDS
END START


;; Created by Ywt.
;; Date: 11/09/2016  

TITLE 4.28_YWT

CALC   MACRO   X, Y, SUM 
        ;; STORE THE REGISTERS
        PUSH AX            
        PUSH DX
        XOR DX, DX
        
        ;; CALCULATE THE SUM
        ADD DX, X
        ADD DX, Y
        MOV AX, X
        CMP AX, Y
        JG XG
        ADD DX, X
        JMP A_SUM
XG:     ADD DX, Y

A_SUM:  MOV SUM, DX
        ;;RESTORE
        POP DX
        POP AX
ENDM

DATA	SEGMENT
    NUM1    DW 3
    NUM2    DW 3
    ANS     DW ?
ENDS

CODE	SEGMENT
	ASSUME CS:CODE, DS:DATA, SS:STACK

START:  MOV AX, DATA
        MOV DS, AX

        CALC NUM1, NUM2, ANS

        ;; FINISH
        MOV AX, 4C00H
        INT 21H
ENDS
END START


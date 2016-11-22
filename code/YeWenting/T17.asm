;; Created by Ywt.
;; Date: 11/21/2016
;;  
;; USE BX TO STORE THE NUMBER
;; USE TEST TO GET BIT

TITLE   T17_YWT

CODE	SEGMENT
	    ASSUME CS:CODE

START:	;; GET INPUT
        XOR BX, BX
        MOV CX, 4
        
READ:   SHL BX, 4
        MOV AH, 1
        INT 21H
        SUB AL, 30H
        CMP AL, 9
        JBE ASSIGN      ;; 0~9
        SUB AL, 7       ;; A~F
ASSIGN: ADD BL, AL
        LOOP READ
        
        MOV AH, 2       ;; PRINT \n
        MOV DL, 0AH
        INT 21H
        MOV DL, 0DH     ;; PRINT \r
        INT 21H
        
        ;; PRINT PART
        ;; CX->OUTER LOOP
        ;; SI->INNER LOOP
        ;; DI->NUMBER EXTRACTER
        MOV CX, 4
OUTER:  MOV DI, 8000H
        MOV SI, 4
TRANS:  TEST BX, DI
        MOV DL, 31H
        JNZ PRINT
        MOV DL, 30H
PRINT:  MOV AH, 2
        INT 21H
        SHR DI, 1
        DEC SI
        JNZ TRANS
        SHL BX, 4
        LOOP OUTER        
        
	    ;; FINISH
	    MOV AH, 4CH
	    INT 21H

ENDS
END START
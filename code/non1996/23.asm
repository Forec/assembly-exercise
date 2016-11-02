DATA SEGMENT        
;    N       EQU 100
    M       DW 50 DUP(0), 50 DUP(1)
    MAX     DW 0
    OFF     DW 0
DATA ENDS


CODE SEGMENT
	ASSUME CS:CODE, DS:DATA
START:
	MOV AX, DATA
	MOV DS, AX
                      
    	MOV SI, OFFSET M                  
    	MOV DI, OFFSET MAX         
    	MOV AX, 0
    	MOV BX, 0
FIND_MAX:
    	CMP [SI], AX
    	JBE NOTLARGER
    	MOV AX, [SI]
    	MOV BX, SI
NOTLARGER:    
    	ADD SI, 2
    
    	CMP SI, DI
    	JNZ FIND_MAX
             
    	MOV MAX, AX
    	MOV OFF, BX
             
	MOV AH, 4CH
	INT 21H
CODE ENDS
	END START
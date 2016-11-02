;--------------------------±£´æ¼Ä´æÆ÷ºÍ»Ö¸´¼Ä´æÆ÷ºê
SAVECONTENT MACRO
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
ENDM

RELOADCONTENT MACRO
    POP DX
    POP CX
    POP BX
    POP AX
ENDM

DATA SEGMENT
    N EQU 100
    TABLE DB N DUP(0)
    CHAR DB 0 
    NUM DW 0
DATA ENDS

CODE SEGMENT
    ASSUME CS:CODE, DS:DATA
START:
    MOV AX, DATA
    MOV DS, AX     
           
    CALL CIN_STRING
    CALL ENTER
    CALL CIN_CHAR
    CALL ENTER
    CALL COUNT
           
    MOV AH, 04CH
    INT 21H

ENTER PROC NEAR
    SAVECONTENT
    
    MOV AH, 02H
    MOV DL, 0DH
    INT 21H
    MOV DL, 0AH
    INT 21H
    
    RELOADCONTENT
    RET
ENTER ENDP

CIN_STRING PROC NEAR 
    SAVECONTENT
    
    MOV BX, 0       
    MOV CX, N
    DEC CX      
GETIN:                 
    MOV AH, 1
    INT 21H
    CMP AL, 0DH
    JZ FINISH
    MOV TABLE[BX], AL
    INC BX
LOOP GETIN
    
FINISH:    
    MOV TABLE[BX], '$' 
;    MOV NUM, BX            
    RELOADCONTENT
    RET
CIN_STRING ENDP
          
CIN_CHAR PROC NEAR
    SAVECONTENT
    
    MOV AH, 1
    INT 21H
    MOV CHAR, AL
    
    RELOADCONTENT
    RET
CIN_CHAR ENDP          
          
COUNT PROC NEAR
    SAVECONTENT
    
    MOV BX, 0
FIND:
    MOV AL, TABLE[BX]
    CMP AL, '$'
    JZ FINI
    CMP AL, CHAR
    JNZ NEXT
    INC NUM
NEXT:       
    INC BX
    JMP FIND
        
FINI:             
    RELOADCONTENT
    RET
COUNT ENDP 

CODE ENDS
    END START
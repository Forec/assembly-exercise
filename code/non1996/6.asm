DATA SEGMENT 
    DATA_LEN    DB 5
    DATA_LIST   DW -1, 0, 2, 5, 4, 0, 0, 0, 0, 0
    MAX         DW 0
    MIN         DW 00FFH
    
DATA ENDS

CODE SEGMENT
    ASSUME CS:CODE DS:DATA
START:          
    MOV AX, DATA
    MOV DS, AX
    
    
    MOV CL, DATA_LEN
    MOV BX, 0    
    CMPLOOP:
        MOV AX, DATA_LIST + [BX]
        ADD BX, 2
        
        CMP AX, MAX
        JLE NOT_LARGER
        MOV MAX, AX
    NOT_LARGER:
        CMP AX, MIN
        JGE NOT_LESS    
        MOV MIN, AX
    NOT_LESS:    
        LOOP CMPLOOP 
              
        MOV AX, MAX
        MOV AX, MIN
CODE ENDS
    END START
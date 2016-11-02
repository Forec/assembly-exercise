DATA SEGMENT
	ARRAY DW 80H DUP(-1), 80H DUP(3)
	ARRAY_END DB 0                        
DATA ENDS

CODE SEGMENT
	ASSUME CS:CODE, DS:DATA
START:
	MOV AX, DATA
	MOV DS, AX

	MOV CX, OFFSET ARRAY_END	
	MOV AX, 0		;求和的低字
	MOV DX, 0		;求和的高字
	MOV SI, OFFSET ARRAY
;--------------------------------------------------求和
SUM:        
    CMP [SI], 0
    JL NEGA
    
	ADD AX, [SI]	
	ADC DX, 0
    JMP CONTINUE
NEGA:
    MOV BX, [SI]
    NEG BX
    SUB AX, BX
    SBB DX, 0

CONTINUE:	
	ADD SI, 2
	CMP SI, CX
	JNZ SUM	

;--------------------------------------------------求平均，ax为平均值
AVERAGE:
	MOV CX, 0100H
	DIV CX

;--------------------------------------------------计算小于平均值的数的数量
	MOV SI, OFFSET ARRAY
	MOV CX, OFFSET ARRAY_END
	MOV BX, 0
COUNT:
	CMP [SI], AX
	JAE LARGER
	INC BX
LARGER:	
	ADD SI, 2
	CMP SI, CX
	JNZ COUNT
		
	MOV AH, 04CH
	INT 21H
CODE ENDS
	END START

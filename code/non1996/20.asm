DATA SEGMENT 
	MEM DW 25 DUP(1, 0, 2, 0)
	TEMP DW 100 DUP(0)
DATA ENDS

CODE SEGMENT
	ASSUME CS:CODE, DS:DATA
START:
	MOV AX, DATA
	MOV DS, AX
;---------------------------------将所有非零值存入临时数组
	MOV DX, 0	;计数器，记录有多少个非零值
	MOV BX, OFFSET MEM
	MOV SI, OFFSET TEMP
	MOV CX, 100	
FIND_NZ:			
	CMP [BX], 0
	JZ ZERO
	
	MOV AX, [BX]
	MOV [SI], AX
	ADD SI, 2
ZERO:
	ADD BX, 2
LOOP FIND_NZ

;---------------------------------把临时数组拷贝给原数组
	MOV BX, OFFSET MEM
	MOV SI, OFFSET TEMP
	MOV CX, 100
CPY:				;将临时数组拷贝进原数组
	MOV AX, [SI]
	MOV [BX], AX
	ADD BX, 2
	ADD SI, 2
	CMP [SI], 0
LOOP CPY
	
	MOV AH, 4CH
	INT 21H
CODE ENDS
	END START
DATA SEGMENT        
;	TABLE DW 30 DUP(-10), 70 DUP(10)
;    TABLE DW 1, 2, 2, 3, 3, 3
    TABLE DW 100H DUP(0)
	LEN DW ($ - TABLE) / 2
	MAX_APPEAR DW 0
	MAX_NUM DW 0
DATA ENDS


CODE SEGMENT
	ASSUME CS:CODE, DS:DATA
START:
	MOV AX, DATA
	MOV DS, AX


	MOV AX, 0		        ;ax记录当前数
	MOV BX, 0		        ;bx记录该数出现的次数

	MOV CX, LEN		        ;
	MOV DX, OFFSET LEN		        ;循环计数器

	MOV SI, OFFSET TABLE	;外层循环下标
	MOV DI, OFFSET TABLE	;内层循环下标

LOOP_FIRST:
	
	MOV AX, [SI]
    MOV DI, SI
	LOOP_SECOND:		    ;内层循环寻找和当前数相同的数，每找到一个计数器加1
		CMP AX, [DI]
		JNZ NEQUAL
		INC BX
		
		ADD DI, 2
		CMP DI, DX		
	JNZ LOOP_SECOND;LOOP_SECOND
	
NEQUAL:
    
	CMP BX, MAX_NUM         ;对比当前数的出现次数是否大于之前最大出现次数
	JNA NEXTLOOPF           ;大于则替换
	MOV MAX_APPEAR, AX
	MOV MAX_NUM, BX	
NEXTLOOPF:		
	MOV SI, DI	
	MOV BX, 0		        ;为下次循环准备
	   
	CMP SI, DX   
    JNZ LOOP_FIRST;LOOP_FISRT
    
    MOV AX, MAX_APPEAR
    MOV CX, MAX_NUM

	MOV AH, 4CH
	INT 21H
CODE ENDS
	END START
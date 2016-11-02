DATA SEGMENT            
    MAX_LEN DW 100
	INPUT_BUF DB 100 DUP(0)
DATA ENDS

STACK SEGMENT STACK
	DW 100 DUP(0)
STACK ENDS

CODE SEGMENT
	ASSUME CS:CODE, DS:DATA, SS:STACK
START:
	MOV AX, DATA
	MOV DS, AX
	MOV AX, STACK
	MOV SS, AX

	MOV BX, OFFSET INPUT_BUF
	CALL GET_STRING			;输入字符串

	CALL COUNT_ALPHA		;计数

	CALL OUTPUT_NUM			;输出子程序
			
	MOV AH, 04CH
	INT 21H

;-------------------------------------------------
;	输出子程序，
;	入口: (DX)要输出的数
;	出口: 无
;-------------------------------------------------
OUTPUT_NUM PROC NEAR
	PUSH AX
	PUSH BX
	PUSH DX

	MOV AX, DX
	MOV BL, 0AH
OUTLOOP:    
	DIV BL
	MOV DL, AH
	ADD DL, '0'
	MOV AH, 02H
	INT 21H
	CMP AL, 0
	JZ OUTLOOP		;输出数量

	POP DX
	POP BX
	POP AX
	RET
OUTPUT_NUM ENDP	

;-------------------------------------------------
;	计数子程序，
;	入口: (BX)字符串地址
;	出口: (DX)非数字字符数
;-------------------------------------------------
COUNT_ALPHA PROC NEAR
	PUSH BX

	MOV DX, 0	
	CMP [BX], '$'	;判断字符串长度是否为0
	JZ FINISH		
COUNTER:
	CMP [BX], '0'
	JB NOT_NUM
	CMP [BX], '9'
	JA NOT_NUM		
	INC DX
NOT_NUM:	
	INC BX
	CMP [BX], '$'	
	JNZ COUNTER

FINISH:	
	POP BX
	RET
COUNT_ALPHA ENDP

;-------------------------------------------------
;	输入字符串子程序，
;	入口: (BX)字符串地址
;	出口: 无
;-------------------------------------------------
GET_STRING PROC NEAR
	PUSH AX
	PUSH BX
	PUSH CX

	MOV CX, WORD PTR MAX_LEN - 1	;初始化循环次数，在字符串的最后加入‘$’
LOOPIN:	
	MOV AH, 1
	INT 21H

	CMP AL, '$' 
	JZ LOOPEND		;判断是否输入'$'

	MOV [BX], AL
	INC BX			;将输入的字符存入内存
	LOOP LOOPIN

LOOPEND: 
    MOV [BX], '$'   ;向字符串末尾加个'$'
    
	MOV AH, 02H
	MOV DL, 0DH
	INT 21H
	MOV DL, 0AH
	INT 21H			;显示回车换行
	
	POP CX
	POP BX
	POP AX
	RET
GET_STRING ENDP

CODE ENDS
	END START
DATA SEGMENT
	MAX_LEN DB 100
	STRING1	DB 100 DUP(0)
	STRING2 DB 100 DUP(0)
	
	NO_MATCH DB 'NO MATCH', 0DH, 0AH, '$'
	MATCH DB 'MATCH', 0DH, 0AH, '$'
DATA ENDS

CODE SEGMENT
	ASSUME CS:CODE, DS:DATA
START:
	MOV AX, DATA
	MOV DS, AX

	MOV BX, OFFSET STRING1
	CALL GET_STRING	
	MOV BX, OFFSET STRING2
	CALL GET_STRING		;获取两个字符串

	MOV SI, OFFSET STRING1
	MOV DI, OFFSET STRING2
	CALL CMP_STRING		;比较字符串
	
	MOV AH, 4CH
	INT 21H

;-------------------------------------------------
;	输入字符串子程序，入口为字符串地址, 由BX存储
;-------------------------------------------------
GET_STRING PROC NEAR
	PUSH AX
	PUSH BX
	PUSH CX

	MOV CX, WORD PTR MAX_LEN - 1	;初始化循环次数，在字符串的最后加入‘$’
LOOPIN:	
	MOV AH, 1
	INT 21H

	CMP AL, 0DH
	JZ LOOPEND		;判断是否输入回车

	MOV [BX], AL
	INC BX			;将输入的字符存入内存
	LOOP LOOPIN

LOOPEND:
	MOV AH, 02H
	MOV DL, 0DH
	INT 21H
	MOV DL, 0AH
	INT 21H			;显示回车换行
	MOV [BX], BYTE PTR '$'		;向字符串末尾加入'$'	
	
	POP CX
	POP BX
	POP AX

	RET
GET_STRING ENDP

;-------------------------------------------------
;	比较字符串子程序，入口为字符串地址, 由SI, 和DI存储
;-------------------------------------------------
CMP_STRING PROC NEAR
	PUSH SI
	PUSH DI
	PUSH CX
	PUSH DX
	
CMP_LOOP:
    MOV CL, [SI]
	CMP CL, [DI]
	JNZ NEQUAL		;比较每个字符
	
	CMP CL, '$'		
	JZ EQUAL		;判断是否到字符串末尾

	INC SI
	INC DI			
	
	JMP CMP_LOOP
	
EQUAL:
	MOV AH, 09H
	MOV DX, OFFSET MATCH
	INT 21H
	JMP FINISH

NEQUAL:
	MOV AH, 09H
	MOV DX, OFFSET NO_MATCH
	INT 21H	
	JMP FINISH

FINISH:	
	POP DX
	POP CX
	POP DI
	POP SI
	RET
CMP_STRING ENDP

CODE ENDS
	END START
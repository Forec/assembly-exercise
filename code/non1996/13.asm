DATA SEGMENT
	MENU DB 'please input integer', 0DH, 0AH, '$'
	N_NUM DB 'please input integer', 0DH, 0AH, '$'
DATA ENDS

STACK SEGMENT
	DW 100H DUP(0)
STACK ENDS

CODE SEGMENT
	ASSUME CS:CODE, DS:DATA, SS:STACK
START:
	MOV AX, DATA
	MOV DS, AX
	MOV AX, STACK
	MOV SS, AX

	CALL GET_INT
	CALL BELL
	
	MOV AH, 4CH
	INT 21H

;-------------------------------------------------
;	输入字符子程序
;	入口：无
;	出口：AL， 输入的数字
;-------------------------------------------------
GET_INT PROC NEAR
	PUSH DX
	
	MOV AH, 09H
	MOV DX, OFFSET MENU
	INT 21H

LOOP_IN:
	MOV AH, 01H
	INT 21H

	CMP AL, '0'
	JB ERROR
	CMP AL, '9'
	JA ERROR	
	JMP OKOK
ERROR:
	MOV AH, 09H
	MOV DX, OFFSET N_NUM
	INT 21H	
	JMP LOOP_IN

OKOK:
	POP DX
	RET
GET_INT ENDP

;-------------------------------------------------
;	响铃子程序
;	入口：AL, 表示响铃次数
;	出口：无
;-------------------------------------------------
BELL PROC NEAR
	PUSH AX
	PUSH CX
	PUSH DX

	MOV CX, 0000H
	MOV CL, AL
	SUB CL, '0'
	MOV DL, 07
	MOV AH, 2
	
LOOP_BELL:
	INT 21H
	LOOP LOOP_BELL
	
	POP DX
	POP CX		
	POP AX
	RET	
BELL ENDP

CODE ENDS
	END START
	
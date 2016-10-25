DATA SEGMENT
	LTOH	DB -32
	CHAR_A  DB 'a'
	CHAR_Z  DB 'z'
	
DATA ENDS
CODE SEGMENT
	ASSUME CS:CODE, DS:DATA
START:
	MOV AX, DATA
	MOV DS, AX

IOLOOP:
	CALL LOWER_IN
	CALL LOW_TO_UP
	CALL OUTPUT	;输入输出子程序调用
	JMP IOLOOP

;FINAL:
	MOV AH, 04CH
	INT 21H

		
;---------接收小写字符的子程序,无入口,出口为AX,存放输入的数
LOWER_IN PROC NEAR
LOOP_IN:
	MOV AH, 8
	INT 21H		;输入字符，不回显
	
	MOV AH, CHAR_A
	CMP AL, AH
	JB LOOP_IN	;判断输入字符是否小于'a'
	MOV AH, CHAR_Z
	CMP AL, AH	
	JA LOOP_IN	;判断输入字符是否大于'z'
	
	RET
LOWER_IN ENDP
;----------------------------------------------------------

;--------------------小写转换为大写的子程序,入口为AX,无出口
LOW_TO_UP PROC NEAR
	ADD AL, LTOH
    
    RET
LOW_TO_UP ENDP
;----------------------------------------------------------

;--------------------------显示字符的子程序,入口为AX,无出口
OUTPUT PROC NEAR
    PUSH DX
    MOV DL, AL
	MOV AH, 2
	INT 21H
	POP DX
	
	RET
OUTPUT ENDP
;----------------------------------------------------------

CODE ENDS
	END START
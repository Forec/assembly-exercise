DATA SEGMENT	
	INBUF DB 4 DUP(0)
	MENU DB 'input your num', 0dh, 0ah, '$'
	ERROR_INPUT DB 'input error!', 0dh, 0ah, '$'
	ENTER DB 0DH, 0AH, '$' 
DATA ENDS

CODE SEGMENT
	ASSUME CS:CODE, DS:DATA
START:
	MOV AX, DATA
	MOV DS, AX
    
    MOV BX, OFFSET INBUF   
    CALL INPUT_HEX		;输入字符串到指定内存空间
	
	MOV CX, 4
	MOV BX, OFFSET INBUF
	
OUTPUT:					;将输入的前4位输出
	MOV AL, [BX]

	CMP AL, '0'
	JB ERROR
	CMP AL, '9'
	JB DECI
	CMP AL, 'A'
	JB ERROR
	CMP AL, 'F'
	JA ERROR
	JMP ALPH				;判断输入是否合法
DECI:
	SUB AL, '0'
	CALL OUTPUT_HEX		;输入为大于0小于9的十六进制数
	JMP GETNEXT
ALPH:	
	SUB AL, 'A'
	ADD AL, 10			;输入为大于A小于F的十六进制数
	CALL OUTPUT_HEX
GETNEXT:
    INC BX
LOOP OUTPUT
    JMP FINISH

ERROR:	
	MOV AH, 09H
	MOV DX, OFFSET ERROR_INPUT
	INT 21H				;输入有误，则输出提示

FINISH:	
	MOV AH, 04CH			;程序结束
	INT 21H
		
;-------------------------------------------------------------------
;	从键盘获取4位十六进制数
;	入口：(BX)保存缓存的地址
;	出口：无
;-------------------------------------------------------------------
INPUT_HEX PROC NEAR
    PUSH AX
    PUSH BX
    PUSH CX 
    PUSH DX
             
    MOV AH, 09H
    MOV DX, OFFSET MENU         
             
    MOV CX, 4
INPUT_LOOP:
    MOV AH, 01H
    INT 21H
    
    MOV [BX], AL
    INC BX
LOOP INPUT_LOOP 

    MOV AH, 09H
	MOV DX, OFFSET ENTER
	INT 21H         ;换行 
	
	POP DX
    POP CX
    POP BX
    POP AX
    
    RET            
INPUT_HEX ENDP
;-------------------------------------------------------------------
;-------------------------------------------------------------------

;-------------------------------------------------------------------
;	将一个十六进制数以2进制输出
;	入口：（DL）
;	出口：无
;-------------------------------------------------------------------
OUTPUT_HEX PROC NEAR
	PUSH AX
	PUSH DX
	PUSH CX	         
	         
	MOV CX, 4	
LOOPOUT:
	MOV DL, AL
	AND DL, 08H		
	CMP DL, 00H
	JZ ZERO			;判断最高位是0还是1

	MOV DL, '1'
	JMP NEXTLOOP
ZERO:
	MOV DL, '0'
NEXTLOOP:	
	MOV AH, 02H 
	PUSH AX
	INT 21H			;每次将最高位输出
	POP AX          ;将AX入栈因为系统调用会改变AL的值
	SHL AL, 1		;AL左移
LOOP LOOPOUT	

	POP CX
	POP DX
	POP AX
	RET
OUTPUT_HEX ENDP
;-------------------------------------------------------------------
;-------------------------------------------------------------------

CODE ENDS
	END START 
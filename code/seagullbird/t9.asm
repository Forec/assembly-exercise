DATA SEGMENT
	BUFF DB 80, ?, 80 DUP (?)
DATA ENDS

CODE SEGMENT
	ASSUME CS:CODE, DS:DATA
START:
	MOV AX, DATA
	MOV DS, AX

	LEA DX, BUFF
	MOV BX, DX 						; 将输入字符的起始地址转存到 BX
	MOV AH, 10
	INT 21H						; 从键盘读入一个字节字符串(没有加容错，必须是小写字母)，DS:DX=存放输入字符的起始地址

	MOV BX, 2
	FOR:
		MOV AL, [BX]				; 取一个字节字符
		CMP AL, 13					; 判断是否是回车符
		JZ	FINAL
		SUB AL, 32
		MOV [BX], AL
		ADD BX, 1
		ADD DX, 1
		JMP FOR
	

	FINAL:
		MOV BX, WORD PTR BUFF[1]
		MOV BH, 0
		ADD BX, 2
		MOV BUFF[BX], 36				; 在末尾放入'$'
		MOV DX, 2
		MOV AH, 9
		INT 21H

		MOV AH, 4CH
		INT 21H
CODE ENDS
	END START
DATA SEGMENT
	BUFF DB 3 DUP (?), '$'
DATA ENDS

CODE SEGMENT
	ASSUME CS:CODE, DS:DATA
START:
	MOV AX, DATA
	MOV DS, AX
	MOV AH, 08H
	INT 21H						; 读入一个字符（无回显）

	MOV BUFF[1], AL
	SUB AL, 1
	MOV BYTE PTR BUFF, AL
	ADD AL, 2
	MOV BUFF[2], AL

	XOR DX, DX
	MOV AH, 9
	INT 21H

	MOV AH, 4CH
	INT 21H	
CODE ENDS
	END START
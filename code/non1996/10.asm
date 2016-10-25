DATA SEGMENT
	ERROR	DB 0DH,0AH,'input error',0DH,0AH,'$'
	CHAR_A  DB 'a'
	CHAR_Z  DB 'z'
DATA ENDS

CODE SEGMENT
	ASSUME CS:CODE, DS:DATA
START:
	MOV AX, DATA
	MOV DS, AX

IOLOOP:
	MOV AH, 8
	INT 21H

	MOV AH, CHAR_A
	CMP AL, AH
	JB IOFIN	;判断输入字符是否小于'a',输入错误则结束程序
	JZ IS_A
	MOV AH, CHAR_Z
	CMP AL, AH	
	JA IOFIN	;判断输入字符是否大于'z',输入错误则结束程序
    JZ IS_Z      
    
    ;输入的字符不是a或z
    MOV AH, 2   
	MOV DL, AL
	DEC DL
	INT 21H
	INC DL
	INT 21H
	INC DL
	INT 21H		;输出三个字符

	JMP IOLOOP
    
IS_A:
    MOV AH, 2
    MOV DL, 'z'
    INT 21H
    MOV DL, 'a'
    INT 21H
    MOV DL, 'b'
    INT 21H
    
    JMP IOLOOP 

IS_Z:
	MOV AH, 2
    MOV DL, 'y'
    INT 21H
    MOV DL, 'z'
    INT 21H
    MOV DL, 'a'
    INT 21H
    
    JMP IOLOOP

IOFIN:    
    MOV AH, 9
    MOV DX, OFFSET ERROR
    INT 21H     ;提示错误信息
    
	MOV AH, 04CH
	INT 21H
CODE ENDS
	END START
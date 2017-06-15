.model small
.code
start:
	mov ah,01h
	int 21h
	add al, 'A' - 'a'
	mov dl,al
	mov ah,02h
	int 21h
	jmp start
end start
title forec_t42

data segment
	a dw ?
	b dw ?
	c dw ?
data ends

code segment
	assume cs:code, ds:data
start:
	mov ax, data
	mov ds, ax
	mov es, ax
	
	cmp a, 1h
	jl yes			;; a < 1
	mov ax, b		;; a >= 1
	mov bx, 4h
	mov dx, 0h
	idiv bx
	cmp ah, 0ah		;; b/4 > 10 ?
	jle no			;; b/4 < = 10 && a >= 1
	mov bx, 8h
	mov dx, 0h
	mov ax, c
	idiv bx
	cmp dx, 5
	jz yes			;; b/4 > 10 && c % 8 == 5
	jmp no			;; b/4 > 10 && c % 8 != 5
	
	yes:
		mov bx, b		;; b
		mov ax, 20		;; a
		add ax, bx
		inc bx
		mov a, ax
		mov b, bx
		mov cl, 2h
		mov ax, c		;; c
		shl ax, cl
		mov c, ax
		jmp quit
	no:
		mov ax, 21		;; a
		mov cx, c		;; c
		inc cx
		sub ax, cx
		mov c, cx
		mov a, ax
		mov bx, b
		dec bx
		mov b, bx

quit:
	mov ah, 4ch
	int 21h
code ends
	end start
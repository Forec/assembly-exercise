title forec_t41

data segment
	h dw ?
	key dw ?
	k dw ?
	i dw ?
	s dw ?
	datas db 100 dup(?)
data ends

code segment
	assume cs:code, ds:data
start:
	mov ax, ds
	mov ds, ax
	mov es, ax
	
	;; (1)
	mov cl, 8
	mov ax, key
	and ax, 0ff00h
	shr ax, cl
	mov h, ax
	
	;; (2)
	mov ax, k
	add ax, '1'
	sub ax, 0abcdh
	mov bx, 38h		;; 56
	mov dx, 0h
	idiv bx
	mov k, ax
	
	;; (3)
	mov cx, 64h
	mov si, 0h		;; i
	mov bx, 0h		;; s
	mov dh, 2h
	loop1:
		mov al, datas[si]
		imul dh
		add bx, ax
		inc si
		loop loop1
	mov s, bx
	mov i, 100
	
	;; (4)
	mov bx, 0h		;; s
	mov cx, 64h		;; i
	mov dh, 2h
	loop2:
		mov al, cl
		mul dh
		add bx, ax
		loop loop2
	mov s, bx
	mov i, 0

quit:
	mov ah, 4ch
	int 21h
code ends
	end start
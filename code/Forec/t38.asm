;; last edit date: 2016/10/26
;; author: Forec
;; LICENSE
;; Copyright (c) 2015-2017, Forec <forec@bupt.edu.cn>

;; Permission to use, copy, modify, and/or distribute this code for any
;; purpose with or without fee is hereby granted, provided that the above
;; copyright notice and this permission notice appear in all copies.

;; THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
;; WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
;; MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
;; ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
;; WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
;; ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
;; OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.

title forec_t38
data segment
	val1 dw 1234h
	bininfo db 'BIN: $'
	octinfo db 'OCT: $'
	skip db 0dh, 0ah, '$'
data ends
stack segment para stack 'stack'
	db 100h dup(?)
stack ends
code segment
	assume cs:code, ds:data
start:
	mov ax, data
	mov ds, ax
	mov es, ax
	call bando

quit_pro:
	mov ah, 4ch
	int 21h
	
bando proc near
	push val1
	call pairs
	ret
bando endp

pairs proc near
	pop bx
	pop ax
	push bx	
	call outbin
	call outoct
	ret
pairs endp

outbin proc near
	push ax
	push bx
	push cx
	push dx
	mov bx, ax
	mov ah, 09h
	mov dx, offset bininfo
	int 21h
	mov cx, 10h
	mov ah, 02h
	loopp1:
		mov dl, bh
		and dl, 10000000b
		push cx
		mov cl, 07h
		shr dl, cl
		pop cx
		add dl, 30h
		int 21h
		shl bx, 1
	loop loopp1
	mov ah, 02h
	mov dl, 'B'
	int 21h			;; 输出 B
	call nextline
	pop dx
	pop cx
	pop bx
	pop ax
	ret
outbin endp	

outoct proc near
	push ax
	push bx
	push cx
	push dx
	mov bx, ax
	mov dx, offset octinfo
	mov ah, 09h
	int 21h
	mov ah, 02h
	mov dl, bh
	and dl, 10000000b
	mov cl, 07h
	shr dl, cl
	add dl, 30h
	int 21h				;; 输出第一位
	shl bx, 1
	mov cx, 05h
	loopp2:
		mov dl, bh
		and dl, 11100000b
		push cx
		mov cl, 05h
		shr dl, cl		;; 八进制右移5位
		mov cl, 03h
		shl bx, cl		;; 原数左移3位
		pop cx
		add dl, 30h
		int 21h
	loop loopp2
	mov ah, 02h
	mov dl, 'O'
	int 21h			;; 输出 O
	call nextline
	pop dx
	pop cx
	pop bx
	pop ax
	ret
outoct endp

nextline proc near
	push ax
	push dx
	mov ah, 09h
	mov dx, offset skip
	int 21h
	pop dx
	pop ax
	ret
nextline endp

code ends
	end start
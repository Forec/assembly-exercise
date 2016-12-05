;; last edit date: 2016/11/23
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

title forec_t43

.model small
.data
	a dw ?
	b dw ?
	c dw ?

.stack 100h
	
.code
start:
	mov ax, @data
	mov ds, ax
	mov es, ax
	
	push a
	push b
	push c
	call calc
	
	mov ah, 4ch
	int 21h
	
calc proc near
	push bp
	mov bp, sp
	push ax
	push bx
	push cx
	push dx
	mov cx, [bp+4]		;; c
	mov bx, [bp+6]		;; b
	mov ax, [bp+8]	;; a
	mov dx, ax
	add dx, bx 		;; a + b 
	cmp dx, cx
	jle	fail			;; a + b <= c
	mov dx, ax
	add dx, cx
	cmp dx, bx
	jle fail			;; a + c <= b
	mov dx, bx
	add dx, cx
	cmp dx, ax
	jle fail			;; b + c <= a
	mov ax, 0h
	sub ax, 1h			;; 0 - 1, cf = 1
	jmp quitproc
	fail:
		sub ax, 0h		;; set cf = 0
quitproc:
	pop dx
	pop cx
	pop bx
	pop ax
	pop bp
	ret	6;; ret 6, 3 parameters, but the order is not normal in debug
calc endp
	end start
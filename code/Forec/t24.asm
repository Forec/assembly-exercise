;; last edit date: 2016/10/25
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

title forec_t24

.model small
.data
	array dw 100h dup (?)

.code
start:
	mov ax, @data
	mov ds, ax
	mov es, ax
	mov ax, 00h
	mov bx, 00h
	mov cx, 100h
	mov dx, 00h
	mov si, 00h
	mov di, 00h
calc:
	cmp si, 200h	;; dw * 2
	jz average
	add ax, array[si]
	adc dx, 00h
	add si, 02h
	jmp calc
average:	
	idiv cx			;; (DX:AX) div (SRC) = AX ... mod DX
compare:
	cmp ax, array[di]
	jle pass
	inc bx
	pass:
		add di, 2h
		loop compare	
quit:
	mov ah, 4ch
	int 21h
	end start
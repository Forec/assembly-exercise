;; last edit date: 2016/11/2
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

title forec_t40

data segment
	X dw 0505h
	Y dw 0a0ah
	SUM dw ?
data ends

code segment
	assume cs:code, ds:data
start:
	mov ax, data
	mov ds, ax
	finsum macro x, y
		push ax
		push bx
		mov ax, x
		mov bx, y
		if ax gt bx
			shl bx, 1
		else
			shl ax, 1
		endif
		add ax, bx
		mov sum, ax
		pop bx
		pop ax
	endm
	
	finsum X, Y
	
	mov ah, 4ch
	int 21h
code ends
	end start
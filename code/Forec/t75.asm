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

title forec_t75

.model small
.data
	buff dw 200 dup (?)
	n1 dw 0
	n2 dw 0
	n3 dw 0
.code
start:
	mov ax, @data
	mov ds, ax
	mov si, 00h
	mov bx, 00h
	mov cx, 00h
	mov dx, 00h
compare:
	cmp si, 200
	jz output
	mov ax, buff[si]
	cmp ax, 0
	jl negative
	jg positive
	inc bx			;; zero
	jmp pass
	negative:
		inc cx		;; negative
		jmp pass
	positive:
		inc dx
	pass:
		inc si
		jmp compare
	
output:
	mov n1, dx		;; positive
	mov n2, bx		;; zero
	mov n3, cx		;; negative

	mov ah, 4ch
	int 21h
	end start
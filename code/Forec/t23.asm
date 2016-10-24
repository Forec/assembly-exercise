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

title forec_t23

.model small

.data
	M dw -4, 8, 9, 123, -9873, 23, 123, 43, 1, 0, 93, 13, 45, 15, 61, -88, ?, ?
	;; 16个数，2个空位
	n equ $ - M - 4
.code
start:
	mov ax, @data
	mov ds, ax
	mov es, ax
	mov si, 00h
	mov ax, 00h
	mov bx, 00h
check:
	cmp si, n
	jz quit
	mov cx, M[si]
	cmp cx, 0h
	jge positive
	neg cx
	positive:
	cmp ax, cx
	jge pass
	mov ax, cx
	mov bx, si
	pass:
		add si, 2h
	jmp check
	
quit:
	mov M[si], ax
	add bx, offset M
	add si, 2h
	mov M[si], bx
	mov ah, 4ch
	int 21h
	end start
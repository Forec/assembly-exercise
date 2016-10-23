;; last edit date: 2016/10/24
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

title forec_t13

.model small
.data
	inputinfo db 'Input: $'
	outputinfo db 0dh, 0ah, 'Output: $'
.code
start:
	mov ax, @data
	mov ds, ax
	mov dx, offset inputinfo
	mov ah, 9h
	int 21h
	mov ah, 01h
	int 21h
	mov cl, al
	sub cl, 030h
	mov dx, offset outputinfo
	mov ah, 9h
	int 21h
	mov ah, 02h
	mov dl, 'a'				;; 07h 用 a 代替 beep 观察输出
beep:
	cmp cl, 00h
	jz quit
	dec cl
	int 21h
	jmp beep
quit:	
	mov ah, 4ch
	int 21h
	end start
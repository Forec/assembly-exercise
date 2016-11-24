;; last edit date: 2016/11/24
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

title forec_t47

.model small
.data
	product dw 45 dup (?)

.code
start:
	mov ax, @data
	mov ds, ax
	
	;; for i = 1; i <= 9; i++
	;;	   for j = 1; j <= i; j++
	;;		   product[index] <- i * j
	
	mov si, offset product		;; index
	mov ax, 01h		;; i
	
	loop1:
		cmp al, 0ah
		jz quit
		mov bl, 01h		;; j
		loop2:
			cmp bl, al
			jg quitLoop2
			mov cx, ax
			mul bl
			mov [si], ax
			mov ax, cx
			inc bl
			add si, 02h
			jmp loop2
		quitLoop2:
			inc al
		jmp loop1
quit:
	mov ah, 4ch
	int 21h
end start
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

title forec_t27

.model small
.data
	array_a db 15 dup(?)
	array_b db 20 dup(?)
	array_c db 15 dup(?)
.stack 100h
.code
start:
	mov ax, @data
	mov ds, ax
	mov es, ax
	
	mov si, 00h
	mov cx, 00h
outside:
	cmp si, 0fh
	jz quit
	mov al, array_a[si]
	mov di, 00h
	inside:
		cmp di, 14h
		jz quitinside
		mov bl, array_b[di]
		cmp al, bl
		jnz pass
		push si
		mov si, cx
		mov array_c[si], bl
		inc cx
		pop si
		pass:
			inc di
			jmp inside
		quitinside:
	inc si
	jmp outside
quit:	
	mov ah, 4ch
	int 21h
	end start
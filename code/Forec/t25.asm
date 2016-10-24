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

title forec_t25

data segment
	mem db 4 dup(?)
data ends

code segment
	assume cs:code, ds:data
start:
	mov ax, data
	mov ds, ax
	mov es, ax
	mov ax, 2A49h	;; (AX) = 2A49H
	mov si, 01h
	mov bl, al		;; 处理 ax 最后 4 位
	and bl, 0fh
	cmp bl, 0ah
	jl number1		;; 0 ~ 9
	add bl, 07h			;; A ~ F
	number1:
	add bl, 30h
	mov mem[0], bl
	mov cl, 04h
	deal:
		cmp si, 04h
		jz quit
		shr ax, cl
		mov bl, al
		and bl, 0fh
		cmp bl, 0ah
		jl number2
		add bl, 07h
		number2:
		add bl, 30h
		mov mem[si], bl
		inc si
		jmp deal
quit:
	mov ah, 4ch
	int 21h
code ends
	end start
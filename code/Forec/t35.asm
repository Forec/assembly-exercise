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

title forec_t35
data segment
	score dw 76, 69, 84, 90, 73, 88, 99, 63, 100, 80
	s6 dw 0h		;; 2
	s7 dw 0h		;; 2
	s8 dw 0h		;; 3
	s9 dw 0h		;; 2
	s10 dw 0h		;; 1
data ends
code segment
	assume cs:code, ds:data
start:
	mov ax, data
	mov ds, ax
	
	mov cx, 0ah
	mov si, 00h
	loopp:
	mov ax, score[si]
	cmp ax, 60
	jl pass
	cmp ax, 70
	jl six_seven		;; 60 < x < 69
	cmp ax, 80
	jl seven_eight		;; 70 < x < 79
	cmp ax, 90
	jl eight_nine		;; 80 < x < 89
	cmp ax, 100
	jl nine_100			;; 90 < x < 99
	jg pass				;; > 100
	mov bx, s10			;; 100
	inc bx
	mov s10, bx
	jmp pass
	six_seven:
		mov bx, s6
		inc bx
		mov s6, bx
		jmp pass
	seven_eight:
		mov bx, s7
		inc bx
		mov s7, bx
		jmp pass
	eight_nine:
		mov bx, s8
		inc bx
		mov s8, bx
		jmp pass
	nine_100:
		mov bx, s9
		inc bx
		mov s9, bx
	pass:
		add si, 02h
	loop loopp
	
	mov ah, 4ch
	int 21h
code ends
	end start
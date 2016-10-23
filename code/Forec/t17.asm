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

title forec_t17

.model small
.data
	store db 4 dup(?)
	errorinfo db 0dh, 0ah, 'Your input is not valid!$'
	inputinfo db 'Input : $'
	outputinfo db 0dh, 0ah, 'Output : $'
.code
start:
	mov ax, @data
	mov ds, ax
	mov dx, offset inputinfo
	mov ah, 09h
	int 21h
	mov si, 0h
	mov ah, 01h
read:
	cmp si, 04h	
	jge outputs		;; si >= 4
	int 21h
	mov store[si], al
	inc si
	cmp al, 30h		;; < '0'
	jl wrong
	cmp al, 66h		;; > 'f'
	jg wrong
	cmp al, 39h		;; <= '9'
	jle read
	cmp al, 41h		;; < 'A'
	jl wrong
	cmp al, 46h		;; <= 'F'
	jle read
	cmp al, 61h		;; >= 'a'
	jge read
	jmp wrong

wrong:
	mov dx, offset errorinfo
	mov ah, 9h
	int 21h
	jmp quit

outputs:
	mov ah, 02h
	mov dl, 'H'
	int 21h				;; 为用户输入补全 'H'
	mov ah, 09h
	mov dx, offset outputinfo
	int 21h
	mov ah, 02h
	mov si, 00h
	foreach:
		cmp si, 04h	
		jge quit		;; si >= 4
		mov ch, store[si]
		sub ch, 30h		;; ascii2num
		mov cl, 00h
		print:
			cmp cl, 08h		;; 已右移 8 次,换下一个数
			jz breakpoint
			mov dl, 30h		;; 默认 0(30h)
			test ch, 80h
			jz pass1		;; 高位为 0, 跳过输出1
			mov dl, 31h
			pass1:
			int 21h
			shl ch, 1
			inc cl
			jmp print
		breakpoint:
		inc si
		mov dl, ' '			;; 补全空格
		int 21h
		jmp foreach

quit:
	mov ah, 4ch
	int 21h
	end start
	
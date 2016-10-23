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

title forec_t14

.model small
.data
	positive db 'Positive numbers :$'
	negative db 0dh, 0ah, 'Negative numbers :$'
	M dw 1, 3, -2, 4, -9, -19, 32, 1, 0, 3, -4, 94, 1030, 32, -1, 13, -32, -12, 56, 7
		;; 20 个数据, 7 个负数， 1个0， 12个正数
.code
start:
	mov ax, @data
	mov ds, ax
	
	mov si, 0h
	mov bx, 0h
compare:
	cmp si, 40
	jz outputs
	mov ax, M[si]
	add si, 02h
	cmp ax, 0
	jz compare
	jl nega
	inc bl			;; bl 存正数个数
	jmp compare
	nega:
		inc bh		;; bh 为负数个数
		jmp compare
	
outputs:	
	mov ch, bh		;; ch 暂存负数个数
	mov bh, 00h
	mov cl, 0ah
	mov dx, offset positive
	mov ah, 09h
	int 21h			;; 输出帮助信息
	cmp bl, 00h
	jnz loopout1
	mov dl, '0'
	mov ah, 02h
	int 21h
	jmp prenega
loopout1:
	mov ax, bx
	div cl
	mov bl, ah		;; 余数
	mov dl, al		;; 商
	cmp dl, 00h
	jz printmod1
	add dl, 30h
	mov ah, 02h
	int 21h
	jmp loopout1
printmod1:
	mov ah, 02h
	mov dl, bl		;; 打印个位数
	add dl, 30h
	int 21h
prenega:
	mov dx, offset negative
	mov ah, 09h
	int 21h
	
	mov bl, ch		;; 从 ch 取出负数个数
	mov bh, 00h
	cmp bl, 00h
	jnz loopout2
	mov dl, '0'
	mov ah, 02h
	int 21h
	jmp quit
loopout2:
	mov ax, bx
	div cl
	mov bl, ah		;; 余数
	mov dl, al		;; 商
	cmp dl, 00h
	jz printmod2
	add dl, 30h
	mov ah, 02h
	int 21h
	jmp loopout2
printmod2:
	mov ah, 02h
	mov dl, bl		;; 打印个位数
	add dl, 30h
	int 21h
quit:
	mov ah, 4ch
	int 21h
	end start
	
;; 输出
;; Positive numbers :12
;; Negative numbers :7
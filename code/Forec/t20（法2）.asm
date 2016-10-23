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

title forec_t20(2)

.model small
.data
	mem dw 1, 0, 0, 0, 2, 0, 0, 3, 0, 4, 0, 5, 6;;, 1000h dup(?)
	;; 13个确定的数用于检查, 重复1000h个随机数
	temp dw 100dh dup(?)
	;; 用 temp 缓存非零数
.code
start:
	mov ax, @data
	mov ds, ax
	mov es, ax
	mov si, offset mem	
	mov di, offset temp
	mov bx, offset mem
	add bx, 201ch 		;;100dh * 2 + 2
	cld
check:
	cmp si, bx
	jz clear
	cmp word ptr [si], 0000h
	jz pass
	movsw
	pass:
		add si, 2h
	jmp check
clear:
	mov cx, di
	mov di, offset mem
	sub cx, offset temp
	mov si, offset temp
	cld
	rep movsw
	sub di, offset mem
	mov cx, 201ch		;;	100dh * 2 + 2
	sub cx, di
	l:
		mov mem[di], 00h
		add di, 2h
		dec cx		;; 字,cx每次要减2
		loop l
quit:
	mov ah, 4ch
	int 21h
	
	end start
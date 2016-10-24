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

title forec_t22

.model small
.data
	table dw 100h dup(?)
	;;	此题也可用栈处理，但所需空间增大
.code
start:
	mov ax, @data
	mov ds, ax
	mov es, ax
	mov si, 00h
	mov ax, 00h				;; ax 暂存出现次数最多的数
	mov bx, 00h				;; bx 暂存最多出现次数
	mov cx, 100h
check:
	cmp si, 100h
	jz quit
	mov di, 00h				;; 下标
	mov cx, 00h				;; 次数
	mov dx, table[si]
	inside:
		cmp di, 100h
		jz quitloop			;; 比较完成
		cmp dx, table[di]
		jnz pass1
		inc cx
		pass1:
			add di, 2h
			jmp inside
	quitloop:
	cmp cx, bx				;;	比较当前次数与最大次数
	jle pass2
	mov bx, cx				;; 	更新最大次数和数
	mov ax, dx
	pass2:
		add si, 2h
		jmp check

quit:	
	mov cx, bx
	mov ah, 4ch
	int 21h
	end start
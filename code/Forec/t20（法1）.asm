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

title forec_t20(1)

.model small
.data
	mem dw 1, 0, 0, 0, 2, 0, 0, 3, 0, 4, 0, 5, 6, 1000h dup(?)
	;;	13个确定的数用于检查, 重复1000h个随机数
.code
start:
	mov ax, @data
	mov ds, ax
	mov es, ax
	mov si, 0000h		;; 当前指针
	mov di, 0000h		;; 指向上一个不为 0 的后面的 0 的指针
check:
	cmp si, 100dh
	jz quit
	cmp mem[si], 00h
	jz pass				;; 当前仍为0则跳过拷贝
	cmp si, di
	jz pass				;; di 和 si 相同则跳过拷贝
	mov cx, 100dh		;; 当前不为 0, 类似 xxx0000000x........
	mov bx, si			;;                     di     si      100dh
	sub cx, bx			;;                  xxxx........
	mov bx, di			;;					   di,si
	add si, offset mem
	add di, offset mem
	cld
	cp:
		movsw
		dec cx
		jnz cp
	clear:
		cmp si, 100dh
		jz finish
		mov mem[si], 00h
		add si, 2h
		jmp clear
	finish:
		mov di, bx
		mov si, bx
	pass:
		add si, 2h
		cmp mem[di], 00h		;; 若当前 mem[di] 不为 0, 则更新 di 和 si 相同
		jz check
		mov di, si
		jmp check
quit:
	mov ah, 4ch
	int 21h
	
	end start
	
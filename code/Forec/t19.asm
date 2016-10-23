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

title forec_t19

.model small
.data
	inputinfo db 'Input:$'
	outputinfo db 'Output:$'
.code
start:
	mov ax, @data
	mov ds, ax
	mov bx, 0h
	mov dx, offset inputinfo
	mov ah, 09h
	int 21h
	mov ah, 01h
read:
	int 21h
	cmp al, '$'
	jz outputs		;; '$' 结束
	cmp al, 0dh
	jz outputs		;; 回车结束
	cmp al, 30h
	jl add1			;; < '0'
	cmp al, 39h	
	jle pass		;; '0' < al <= '9'
	add1:
		inc bx
	pass:
		jmp read

outputs:
	mov dx, offset outputinfo
	mov ah, 09h
	int 21h
	
	mov cl, 0ah
	cmp bx, 0000h
	jnz outputdec
	mov dl, '0'
	mov ah, 02h
	int 21h
	jmp quit
outputdec:
	mov ax, bx
	div cl
	mov bl, ah		;; 余数
	mov dl, al		;; 商
	cmp dl, 00h
	jz printmod
	add dl, 30h
	mov ah, 02h
	int 21h
	jmp outputdec
printmod:
	mov ah, 02h
	mov dl, bl		;; 打印个位数
	add dl, 30h
	int 21h

quit:
	mov ah, 4ch
	int 21h
	end start
	
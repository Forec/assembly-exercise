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

title forec_t12

.model small
.data
	output db 'ANS: $'
	matchinfo db 'MATCH$'
	nomatchinfo db 'NO MATCH$'
	warninginfo db 0dh, 0ah, 'You can input at most 100 chars!', 0dh, 0ah, '$'
	inputinfo db 'input str$'
	str1 db 100 dup(?)
	str2 db 100 dup(?)
.code
start:
	mov ax, @data
	mov ds, ax
	mov dx, offset inputinfo		;; 显示帮助信息
	mov ah, 9h
	int 21h
	mov dl, '1'
	mov ah, 2h
	int 21h
	mov dl, ':'
	int 21h
					;; 输入str1
	mov si, 0h
	mov ah, 1h
input1:
	int 21h
	mov str1[si], al
	inc si
	cmp al, 0dh
	jz pre2
	cmp si, 100
	jl input1
	mov dx, offset warninginfo		;; 超过100字符，提示警告
	mov ah, 9h
	int 21h

pre2:	
	mov dx, offset inputinfo		;; 显示帮助信息
	mov ah, 9h
	int 21h
	mov dl, '2'
	mov ah, 2h
	int 21h
	mov dl, ':'
	int 21h
	
	mov di, 0h
	mov ah, 1h
input2:
	int 21h
	mov str2[di], al
	inc di
	cmp al, 0dh
	jz compare
	cmp di, 100
	jl input2
	mov dx, offset warninginfo		;; 超过100字符，提示警告
	mov ah, 9h
	int 21h
compare:
	mov dx, offset output			;; 显示 "ANS: "
	mov ah, 9h
	int 21h
	cmp si, di
	jnz unmatch
	dec si
	cmpchar:
		cmp si, 0h
		jz match
		mov bh, str1[si]
		mov bl, str2[si]
		cmp bh, bl
		jnz unmatch
		dec si
		jmp cmpchar
unmatch:
	mov dx, offset nomatchinfo
	jmp quit
match:
	mov dx, offset matchinfo
quit:
	int 21h
	
	mov ah, 4ch
	int 21h
	end start
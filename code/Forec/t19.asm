;; last edit date: 2016/11/18
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
.stack 100h
.code
start:
	mov ax, @data
	mov ds, ax
	mov es, ax
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
	
	push bx
	call outputnumber

	mov ah, 4ch
	int 21h
	
outputnumber proc near
	pop bp				;; bp <- ip
	pop ax
	push bp
	cmp ax, 0ah
	jl only1
	mov cl, 0ah
	div cl
	mov bl, ah		;; 余数
	mov dl, al		;; 商
	mov dh, 00h
	push bx
	push dx
	call outputnumber
	pop bx
	mov ah, 02h
	add bl, 30h
	mov dl, bl
	int 21h
	ret
only1:
	mov dl, al
	add dl, 30h
	mov ah, 02h
	int 21h
	ret
outputnumber endp
	
	end start

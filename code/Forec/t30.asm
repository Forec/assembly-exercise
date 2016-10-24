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

title forec_t30

.model small
.data
	inputinfo db 'Input: $'
	errorinfo db 0dh, 0ah, 'You can input at most 65535 chars!', 0dh, 0ah, '$'
	nextline db 0dh, 0ah, '$'
	letterinfo db 'Letter: $'
	numberinfo db 'Number: $'
	otherinfo db 'Other: $'
.stack 100h
.code
start:
	mov ax, @data
	mov ds, ax
	mov es, ax
	
	mov dx, offset inputinfo
	mov ah, 9h
	int 21h
	
	mov si, 00h			;; total
	mov ah, 01h
	mov bx, 00h			;; letter
	mov cx, 00h			;; number
read:
	cmp si, 0ffffh
	jz warning
	int 21h
	cmp al, 0dh
	jz outputs
	inc si
	cmp al, 30h
	jl read				;; other
	cmp al, 39h
	jle isnumber		;; '0' <= '9'
	cmp al, 41h		
	jl read				;; '9' < 'a'
	cmp al, 5ah
	jle isletter		;; 'a' <= 'z'
	cmp al, 61h
	jl read				;; 'z' < 'A'
	cmp al, 7ah
	jle isletter		;; 'A' <= 'Z'
	jmp read			;; other
	isletter:
		inc bx
		jmp read
	isnumber:
		inc cx
		jmp read
	
warning:
	mov dx, offset errorinfo
	mov ah, 09h
	int 21h
	
outputs:
	sub si, bx
	sub si, cx
	push si
	push cx
	push bx
	
	mov dx, offset letterinfo
	mov ah, 09h
	int 21h
	call outputnumber		;; letter: xxx
	call nl
	
	mov dx, offset numberinfo
	mov ah, 09h
	int 21h
	call outputnumber		;; number: xxx
	call nl
	
	mov dx, offset otherinfo
	mov ah, 09h
	int 21h
	call outputnumber		;; other: xxx	
	call nl
	
quit:	
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

nl proc near
	mov dx, offset nextline
	mov ah, 09h
	int 21h
	ret
nl endp
	end start
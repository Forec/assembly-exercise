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

title forec_t10

.model small
.data
	helpinfo db 'Input: $'
	outputinfo db 0dh, 0ah, 'Output: $'
	errorinfo db 0dh, 0ah, 'Your input is not lowercase letter!$'

.code
start:
	mov ax, @data
	mov ds, ax
	
	mov dx, offset helpinfo	
	mov ah, 9h
	int 21h
	
	mov ah, 1h
	int 21h
	cmp al, 0dh
	jz quit			;; 回车
	cmp al, 'a'	
	jb quit			;; < 'a'
	cmp al, 'z'		
	ja quit			;; > 'z'
	mov dx, offset outputinfo
	mov ah, 9h
	int 21h
	mov ah, 2h
	cmp al, 61h
	jz ia				;; 是 'a'
	cmp al, 7ah			
	jz iz				;; 是 'z'
	;; 不是 'a' 或 'z'
	dec al
	mov dl, al
	int 21h
	inc dl
	int 21h
	inc dl
	int 21h
	jmp quit
ia:
	mov dl, 7ah
	int 21h
	mov dl, 61h
	int 21h
	inc dl
	int 21h
	jmp quit
iz:
	mov dl, 79h
	int 21h
	inc dl
	int 21h
	mov dl, 61h
	int 21h
	jmp quit
	
warning:
	mov dx, offset errorinfo
	mov ah, 9h
	int 21h
quit:
	mov ah, 4ch
	int 21h
	end start
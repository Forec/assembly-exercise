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

title forec_t9

.model small
.data
	inputinfo db 100 dup(?)
	helpinfo db 'Input: $'
	outputinfo db 'Output: $'
	warninfo db 0dh, 0ah, 'Warning: You have input 100 letters, up to size!', 0dh, 0ah, '$'

.code
start:
	mov ax, @data
	mov ds, ax
	
	mov dx, offset helpinfo	
	mov ah, 9h
	int 21h
	
	mov si, 0h
	mov ah, 1h
let0:
	int 21h
	mov inputinfo[si], al
	inc si
	cmp al, 0dh
	jz let1
	cmp si, 100
	jl let0
	mov dx, offset warninfo
	mov ah, 9h
	int 21h	
let1:
	mov bx, 0h
	mov dx, offset outputinfo
	mov ah, 9h
	int 21h
let2:
	and inputinfo[bx], 0dfh
	mov dl, inputinfo[bx]
	mov ah, 2h
	int 21h
	inc bx
	dec si
	jnz let2
	mov ah, 4ch
	int 21h
	end start
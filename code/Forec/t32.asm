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

title forec_t32

data segment
	program dd 5 dup(?)
	inputinfo db 'Input: $'
	errorinfo db 0dh, 0ah,'Input can only between 1 and 5!', 0dh, 0ah, '$'
	outputinfo db 'Start executing program $'
	nextline db 0dh, 0ah, '$'
data ends

code segment
	assume cs:code, ds:data
start:
	mov ax, data
	mov ds, ax
	
read:
	mov ah, 09h
	mov dx, offset inputinfo
	int 21h
	mov ah, 01h
	int 21h
	cmp al, 30h		;;	'0'
	jl warning
	cmp al, 39h		;;	'9'
	jg warning
	jmp execute
	warning:
		mov ah, 9h
		mov dx, offset errorinfo
		int 21h
	jmp read
execute:	
	;; execute
	mov bl, al
	mov bh, 00h
	sub bx, 30h
	;; call dword ptr program[bx]

	mov ah, 09h
	mov dx, offset nextline
	int 21h
	mov dx, offset outputinfo
	int 21h
	mov ah, 02h
	mov dl, al
	int 21h
	mov ah, 09h
	mov dx, offset nextline
	int 21h
	
	mov ah, 4ch
	int 21h
code ends
	end start
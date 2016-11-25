;; last edit date: 2016/11/25
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

title forec_t50

.model small
.data
	string db "  hello world 1234 $"
	slength equ $-string

.code
start:
	mov ax, @data
	mov ds, ax
	mov si, offset string
	mov bx, offset string
	mov cx, slength
	loop1:
		mov al, [si]
		cmp al, 20h
		jnz cmpNum
		jmp pass
		cmpNum:
		cmp al, 30h
		jl next
		cmp al, 39h
		jg next
		jmp pass
		next:
		mov [bx], al
		inc bx
		pass:
		inc si
		loop loop1
	mov al, 24h
	mov [bx], al
	
	mov dx, offset string
	mov ah, 09h
	int 21h

	mov ah, 4ch
	int 21h
end start
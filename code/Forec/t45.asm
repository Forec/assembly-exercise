;; last edit date: 2016/11/24
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

title forec_t45

code segment
	assume cs:code
start:
	mov cx, 0aaaah	;; 10101010 10101010 -> 11001100 11001100
	
	mov ax, cx
	mov bx, cx
	mov cx, 8h
	
	loop1:
		shr ah, 01h
		jc hzero
		or bx, 0001h
		jmp checkL
		hzero:
			and bx, 0fffeh
	
		checkL:
		shl bx, 01h
		shr al, 01h
		jc lzero
		or bx, 01h
		jmp continueLoop
		lzero:
			and bx, 0fffeh
		continueLoop:
			cmp cx, 01h
			jz quit
			shl bx, 01h
		loop loop1
quit:
	mov cx, bx
	
	mov ah, 4ch
	int 21h
code ends
	end start
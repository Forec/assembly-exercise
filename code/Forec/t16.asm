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

title forec_t16

.model small
.data
	mes db 'The number of 11b in ax is : $'
.code
start:
	mov ax, @data
	mov ds, ax
	mov ax, 0111110111001101b		;; 4 个 11b, ax = 7dcdh
	mov bx, ax
	mov cl, 00h
	mov ch, 00h
compare:
	cmp cl, 0010h
	jz print
	mov ax, bx
	shr ax, cl
	add cl, 02h
	test ax, 0001h
	jz compare
	test ax, 0002h
	jz compare
	inc ch
	jmp compare
print:
	mov dx, offset mes
	mov ah, 09h
	int 21h
	mov dl, ch
	add dl, 30h
	mov ah, 02h
	int 21h
quit:
	mov ah, 4ch
	int 21h
	end start
	
;; 输出
;; The number of l11b in ax is : 4
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

title forec_t11

.model small
.code
start:
	mov ax, 01234h		;; 假设 AX 中 16 位为 1234h
	mov bl, al
	mov dl, ah
	and al, 0fh			;; al
	and bl, 0f0h
	mov cl, 04h
	shr bl, cl			;; bl
	and dl, 0f0h
	shr dl, cl			;; dl
	mov cl, ah
	and cl, 0fh			;; cl
	mov ah, 00h			;; 此时 al, bl, cl, dl 为 04h, 03h, 02h, 01h
	mov ah, 4ch
	int 21h
	end start
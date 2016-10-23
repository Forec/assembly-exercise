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

title forec_t8

d_seg segment
	augend dd 99251
	sum dd ?
d_seg ends

e_seg segment
	augadd dd -15962
e_seg ends

code segment
	assume cs:code, ds:d_seg, es:e_seg
	start:
	mov ax, d_seg
	mov ds, ax
	mov ax, e_seg
	mov es, ax
	mov ax, word ptr augend
	mov bx, word ptr augadd
	add ax, bx
	mov dx, word ptr augend[2]
	mov bx, word ptr augadd[2]
	adc dx, bx
	mov word ptr sum, ax
	mov word ptr sum[2], dx
	mov ah, 4ch
	int 21h
code ends
	end start
	
;; ans is 83289, store in cs:0004-0008, 59 45 01 00
	
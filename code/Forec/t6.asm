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

title forec_t6

data_seg segment
	five db 5
	data_list dw -1, 0, 2, 5, 4, 5 dup(?)
	max dw ?
	min dw ?
data_seg ends

code segment
	assume cs:code, ds:data_seg
	start:
	mov ax, data_seg
	mov ds, ax
	mov cx, 5h
	mov si, 0h
	mov ax, data_list[si]
	mov bx, data_list[si]
let0:
	dec cx
	cmp cx, 0h
	jz quit
	add si, 2h
	cmp ax, data_list[si]
	jle let1
	mov ax, data_list[si]
let1:
	cmp bx, data_list[si]
	jge quit
	mov bx, data_list[si]
	jmp let0
quit:
	mov max, ax
	mov min, bx
	mov ah, 4ch
	int 21h
code ends
	end start
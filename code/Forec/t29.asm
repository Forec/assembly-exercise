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

title forec_t29

.model small
.data
	array dw 0100h, 0100h, 0010h
	outputinfo db 'Output: $'
.code
start:
	mov ax, @data
	mov ds, ax
	mov es, ax
	
	mov dx, offset outputinfo
	mov ah, 09h
	int 21h
	
	mov ax, array[0]
	mov bx, array[2]
	mov cx, array[4]
	
	cmp ax, bx
	jz asb			;; ax == bx
	cmp bx, cx		;; ax != bx
	jz asb			;; bx == cx
	cmp ax, cx		;; ax != bx, bx != cx
	jz asc
	mov ah, 02h
	mov dl, 30h
	int 21h
	jmp quit
asb:
	cmp ax, cx
	jnz show1		;; ax == bx, ax != cx
	mov ah, 02h
	mov dl, 32h
	int 21h
	jmp quit
asc:
	cmp bx, cx		;; ax == cx
	jnz show1		;; bx != cx
	mov ah, 02h
	mov dl, 32h
	int 21h
	jmp quit
show1:
	mov ah, 02h
	mov dl, 31h
	int 21h
quit:	
	mov ah, 4ch
	int 21h
	end start
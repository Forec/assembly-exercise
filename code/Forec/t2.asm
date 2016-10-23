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

title forec_t2

partial STRUC
xname db 'default'
xnumber db 0
partial ends            
            
data segment
    fld1b db 'personal computer'
    fld2b db 32
    fld3b db 20h
    fld4b db 01011001b
    fld5b db '32654'
    fld6b db 10 dup(0)
    fld7b partial <'part1', 20>, <'part2', 50>, <'part3', 14>   
    fld1w dw 0fff0h
    fld2w dw 01011001b
    fld3w equ offset fld7b
    fld4w dw 5, 6, 7, 8, 9
    fld5w dw 5 dup(0)
    fld6w equ ((offset fld1w) - (offset fld1b))
data ends   

code segment			;; code 段用于debug观察数据段
    assume cs:code, ds:data
    start:
	mov ax, data
	mov ds, ax
	lea ax, fld1b
	lea bx, fld5w
let0:
	inc ax
	cmp ax, bx
	JL let0
	mov ah, 4ch
	int 21
code ends
    end start

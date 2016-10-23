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

title forec_t1

data segment
    array dw 23, 36, 2, 100, 32000, 54, 0
    zero dw 1           ;; zero单元初始设为 1，方便对照
ends

code segment
    assume cs:code, ds:data
starts:
    mov ax, data
    mov ds, ax
    lea bx, array       ;; bx 包含数组 array 初始地址
    mov [bx + 7*2], 0h  ;; 将数据 0 传入 zero 单元 
    mov zero, 1h        ;; 将数据 1 传入 zero 单元，方便对照
    lea bx, array[12]   ;; bx 包含数据 0 在 array 数组中位移量   
    mov [bx+2], 0h      ;; 将数据 0 传入 zero 单元                                         
	mov ah, 4ch
	int 21h
ends
    end starts
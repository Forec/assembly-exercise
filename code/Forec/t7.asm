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

title forec_t7

data segment at 0e000h
	array_b label byte		;; 定义字节类型
	array_w dw 50 dup(?)	;; 100字节数组，字类型
data ends

stack segment para stack 'stack'
	dw 100h dup (?)
	top label word
stack ends

code segment
	assume cs:code, ds:data, ss:stack
	org 1000h		;; 从 1000h 开始主程序
	start:
	mov ax, stack
	mov ss, ax		;; 为堆栈寄存器赋值
	mov sp, offset top	;; 为 sp 赋值
	mov ax, data
	mov ds, ax
	;; your code here
	mov ah, 4ch
	int 21h
code ends
	end start
	
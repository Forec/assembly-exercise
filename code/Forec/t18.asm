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

title forec_t18

.model small
.data
	eng db 1000 dup(0)
	tocmp db 'SUN$'
	inputinfo db 'Input:$'
	outputinfo db 'SUN:$'
	warninginfo db 0dh, 0ah, 'You can input at most 1000 chars!', 0dh, 0ah, '$'
.code
start:
	mov ax, @data
	mov ds, ax
	mov es, ax
	mov dx, offset inputinfo
	mov ah, 9h
	int 21h				;; 显示帮助信息
	
	mov ah, 1h
	mov si, 0h
read:
	cmp si, 1000
	jge warning
	int 21h
	cmp al, 0dh
	jz filter			;; 用户输入回车
	mov eng[si], al
	inc si
	jmp read

warning:
	mov dx, offset warninginfo
	mov ah, 9h
	int 21h
	
filter:
	mov di, 0h
	foreach:
		cmp di, si
		jz work
		mov bl, eng[di]
		cmp bl, 61h			;; < 'a'
		jl pass1
		cmp bl, 7ah			;; > 'z'
		jg pass1
		and bl, 0dfh		;; 11011111
		mov eng[di], bl
		pass1:
			inc di
		jmp foreach

work:
	mov ax, 0000h
	mov bx, si
	mov dx, 0000h
curcmp:
	cmp dx, bx
	jz outputs
	mov si, offset eng			;; 当前待比较地址
	add si, dx
	mov di, offset tocmp		;; 'SUN' 地址
	mov cx, 0003h				;; 比较长度为3
	cld
	lp1:
		cmp cx, 0000h
		jnz stcmp				;; 尚未比较完成
		inc ax					;; 相等
		jmp lp2
		stcmp:
			cmpsb
			jnz lp2				;; 不等,跳过
			dec cx				;; 待比较长度减1
			jmp lp1
	lp2:
		inc dx
		jmp curcmp
	
outputs:
	mov bx, ax
	mov dx, offset outputinfo
	mov ah, 09h
	int 21h
	
	mov cl, 0ah
	cmp bx, 0000h
	jnz outputdec
	mov dl, '0'
	mov ah, 02h
	int 21h
	jmp quit
outputdec:
	mov ax, bx
	div cl
	mov bl, ah		;; 余数
	mov dl, al		;; 商
	cmp dl, 00h
	jz printmod
	add dl, 30h
	mov ah, 02h
	int 21h
	jmp outputdec
printmod:
	mov ah, 02h
	mov dl, bl		;; 打印个位数
	add dl, 30h
	int 21h

quit:
	mov ah, 4ch
	int 21h
	end start
	
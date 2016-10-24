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

title forec_t36
data segment
	table db 0efffh dup(?)
	nn dw ?
	char db ?
	time dw ?
	stringinfo db 'Input string: $'
	inputinfo db 'Input char to search: $'
	warninginfo db 0dh, 0ah, 'You can input at most 61439 chars!', 0dh, 0ah, '$'
	skip db 0dh, 0ah, '$'
	outputinfo db ' appeared $'
	outputpart2 db ' times in string.', 0dh, 0ah, '$'
data ends
stack segment para stack 'stack'
	db 100h dup(?)
stack ends
code segment
	assume cs:code, ds:data
start:
	mov ax, data
	mov ds, ax
	mov es, ax
	
	mov ah, 09h
	mov dx, offset stringinfo
	int 21h
	
	mov si, 00h
	mov ah, 01h	
read:
	cmp si, 0efffh
	jz warning
	int 21h
	cmp al, 0dh
	jz run
	mov table[si], al
	inc si
	jmp read

warning:
	mov ah, 09h
	mov dx, offset warninginfo
	int 21h

run:
	mov nn, si
find:
	mov ah, 09h
	mov dx, offset inputinfo
	int 21h
	mov ah, 01h
	int 21h
	cmp al, 0dh
	jz quit				;; 回车退出
	mov char, al
	
	call search
	
	mov ah, 09h
	mov dx, offset skip
	int 21h
	
	mov ah, 02h			;; 显示字符
	mov dl, char
	int 21h
	
	mov ah, 09h
	mov dx, offset outputinfo	;; 显示 appear
	int 21h
	
	mov ax, time
	push ax
	
	call outputnumber			;;	 显示次数
	
	mov ah, 09h
	mov dx, offset outputpart2
	int 21h
	jmp find
	
quit:
	mov ah, 4ch
	int 21h
	
search proc near
	push ax
	push bx
	push cx
	push si
	
	mov si, 00h
	mov bx, 00h
	mov cx, nn
	mov al, char
	loopp:
		cmp al, table[si]
		jnz pass
		inc bx
	pass:
		inc si
	loop loopp
	
	mov time, bx
	pop si
	pop cx
	pop bx
	pop ax
	ret
search endp

outputnumber proc near
	pop bp				;; bp <- ip
	pop ax
	push bp
	cmp ax, 0ah
	jl only1
	mov cl, 0ah
	div cl
	mov bl, ah		;; 余数
	mov dl, al		;; 商
	mov dh, 00h
	push bx
	push dx
	call outputnumber
	pop bx
	mov ah, 02h
	add bl, 30h
	mov dl, bl
	int 21h
	ret
only1:
	mov dl, al
	add dl, 30h
	mov ah, 02h
	int 21h
	ret
outputnumber endp
	
code ends
	end start
;; last edit date: 2016/10/26
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

title forec_t37
data segment
	inputnameinfo db 'INPUT NAME: $'
	inputtelinfo db 'INPUT A TELEPHONE NUMBER: $'
	errorinfo db 0dh, 0ah, 'Input can only between 0-9 or */#!$'
	warninginfo db 0dh, 0ah, 'Name cannot longer than 16 !', 0dh, 0ah, '$'
	outputinfo db 0dh, 0ah, 'NAME               TEL', 0dh, 0ah, '$'
	inbuf db 32 dup(?)		;; 16 name + 8 tel + 8 space
	totallen dw ?
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
	
	call telist
	
quit_pro:
	mov ah, 4ch
	int 21h

telist proc near
	mov ah, 09h
	mov dx, offset inputnameinfo
	int 21h
	call input_name
	mov ah, 09h
	mov dx, offset inputtelinfo
	int 21h
	call inphone
	call printline
	ret
telist endp

input_name proc near
	mov si, 00h
	mov ah, 01h
readname:
	cmp si, 10h		;; 16
	jz warning_name
	int 21h
	cmp al, 0dh		;; 回车
	jz quit_name
	mov inbuf[si], al
	inc si
	jmp readname
warning_name:
	mov ah, 09h
	mov dx, offset warninginfo
	int 21h
quit_name:
	mov totallen, si
	ret
input_name endp
	
inphone proc near
	mov si, totallen
	mov cx, 13h		;; 19	(16 name + 3space)
	sub cx, si
	fillspace:
		mov inbuf[si], ' '
		inc si
		loop fillspace
	
	mov cx, 08h
	mov ah, 01h
	read_phone:
		int 21h
		cmp al, 39h 		;; '9'			'#':23h, '*':2ah
		jg errorinput
		cmp al, 23h	
		jz load				;; is '#'
		cmp al, 2ah			
		jz load				;; is '*'
		cmp al, 30h
		jl errorinput
		load:
			mov inbuf[si], al
			inc si
		loop read_phone
	mov totallen, si
	ret
errorinput:
	mov ah, 09h
	mov dx, offset errorinfo
	int 21h
	jmp quit_pro
inphone endp

printline proc near
	mov ah, 09h
	mov dx, offset outputinfo
	int 21h
	mov si, totallen
	mov inbuf[si], '$'
	mov ah, 09h
	mov dx, offset inbuf
	int 21h
	ret	
printline endp

code ends
	end start
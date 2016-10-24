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

title forec_t26

data segment
	grade dw 0110h, 1000h, 100dh, 0001h, 0110h, 1001h, 0110h, 1002h, 002dh, 0010h, 0100h, 0200h, 0300h, 0400h, 0500h, 0600h, 0700h, 0800h, 0101h, 0202h, 0203h, 0104h, 0305h, 0506h, 0607h, 0207h, 080ah, 070dh, 0fffh, 0ffeh
	temp dw 30 dup(?)
	rank db 30 dup(1)
	outputinfo1 db 'Student $'
	outputinfo2 db ' score : $'
	outputinfo3 db ' rank: $'
	nextline db 0dh, 0ah, '$'
data ends

code segment
	assume cs:code, ds:data
start:
	mov ax, data
	mov ds, ax
	mov es, ax
	
	mov si, offset grade
	mov di, offset temp
	mov cx, 1eh
	rep movsw			;; copy to temp
	
	mov si, 00h
compare:	
	cmp si, 3ch
	jz outputpart
	mov di, 00h
	mov bl, 01h
	mov ax, temp[si]
	nextcmp:
		cmp di, 3ch
		jz setrank
		cmp ax, temp[di]
		jae pass
		inc bl
		pass:
			add di, 2h
		jmp nextcmp
		setrank:
			shr si, 1
			mov rank[si], bl
			shl si, 1
	add si, 2h
	jmp compare
	
	;; output part

outputpart:	
	mov si, 00h
	mov di, 00h
	
outputs:
	cmp si, 3ch		;; 1eh * 2 = 3ch
	jge quit
	mov cl, 0ah	
	mov ax, di			;; 输出 'Student xx score:
	div cl
	add ax, 3030h		;; to ascii
	mov bx, ax
	mov dx, offset outputinfo1
	mov ah, 9h
	int 21h
	mov ah, 2h
	mov dl, bl
	int 21h				;; 十位
	mov dl, bh			;; 个位
	int 21h
	mov dx, offset outputinfo2
	mov ah, 9h
	int 21h
	
	mov ah, 02h
	mov cl, 04h
	mov bx, temp[si]
	mov ch, 00h
printnumber:	
	cmp ch, 04h
	jz printleft
	mov dl, bh
	and dl, 0f0h
	shr dl, cl
	cmp dl, 09h
	jle number
	add dl, 07h
	number:
		add dl, 30h
	int 21h
	shl bx, cl
	inc ch
	jmp printnumber
printleft:
	mov dx, offset outputinfo3
	mov ah, 9h
	int 21h				;; 输出 ' rank : '
	mov bl, 0ah
	mov ah, 00h
	mov al, rank[di]
	div bl
	mov bx, ax
	mov ah, 02h
	mov dl, bl
	add dl, 30h
	int 21h
	mov dl, bh
	add dl, 30h
	int 21h
	mov ah, 9h
	mov dx, offset nextline
	int 21h
	add si, 02h
	inc di
	jmp outputs
quit:
	mov ah, 4ch
	int 21h
code ends
	end start
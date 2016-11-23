;; last edit date: 2016/11/23
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

title forec_t44

.model small
.data
	BUFFER dw 09h, 08h, 07h, 00h, 06h, 04h, 04h, 04h, 03h, 03h
		   dw 02h, 09h, 08h, 07h, 06h, 05h, 04h, 03h, 02h, 01h
	BUFMAX equ 20
	TEMP1 dw 0		;; end address of array
	TEMP2 dw 0		;; first address of array
.stack 100h
.code
start:
	mov ax, @data
	mov ds, ax
	mov es, ax

	mov ax, offset BUFFER
	mov bx, BUFMAX
	push ax
	push bx
	call far ptr sort
	
	mov ah, 4ch
	int 21h

sort proc far
	;; 2 parameters, the first is the address of data to be
	;; sort, the second is the number of words in the array
	push bp
	mov bp, sp
	push si
	push dx
	push cx
	push bx
	push ax

	mov ax, [bp+6]	;; length
	mov bl, 2h
	mul bl			
	mov cx, [bp+8]	;; address of the first element of array
	add ax, cx		;; word is 2 bytes, now ax is the end of array
	mov TEMP1, ax
	
	mov TEMP2, cx
	mov si, TEMP2		;; i
	
	loop1:
		cmp si, TEMP1
		jge quitLoop1
		mov bx, TEMP2		;; j
		mov dx, TEMP1
		sub dx, si		;; arr.length - 1 - i
		add dx, offset BUFFER
		
		loop2:
			cmp bx, dx
			jge quitLoop2
			mov ax, [bx]
			mov cx, [bx+2]
			cmp ax, cx
			jle continueLoop2
			mov [bx], cx
			mov [bx+2], ax
			continueLoop2:
				add bx, 2h
				jmp loop2
		quitLoop2:
		
		add si, 2h			
		jmp loop1
		
	;; bubble sort
	;; for i = 0; i < arr.length - 1; i++
	;;		for j = 0; j < arr.length - 1 - i; j++
	;;			if arr[j] > arr[j+1]
	;;				swap arr, j, j+1
quitLoop1:
	pop ax
	pop bx
	pop cx
	pop dx
	pop si
	pop bp
	ret 4			;; 2 parameters
sort endp	
end start
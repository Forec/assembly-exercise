;; last edit date: 2016/11/1
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

title forec_t9

data segment
    ; add your data here!
    pkey db 0ah, 0dh, "press any key...$"  
    mess1 db 0ah, 0dh, 'input:$'
    mess2 db 0ah, 0dh, 'output:$'
    buff db 10, 0, 10 dup(0)
ends

stack segment
    dw   128  dup(0)
ends

code segment                 
    assume cs:code, ds:data
start:
; set segment registers:
    mov ax, data
    mov ds, ax
    mov es, ax

prog1:
    mov dx, offset mess1
    mov ah, 9
    int 21h
    mov dx, offset buff
    mov ah, 10
    int 21h
    mov cl, buff+1
    mov bx, 2
    mov dx, offset mess2
    mov ah, 9
    int 21h
let1:
    and buff[bx], 0dfh
    mov dl, buff[bx]
    mov ah, 2
    int 21h
    inc bx
    dec cl
    jnz let1
            
    lea dx, pkey
    mov ah, 9
    int 21h 
    
    ; wait for any key....    
    mov ah, 1
    int 21h
    
    mov ax, 4c00h ;
    int 21h    
ends

end start ;

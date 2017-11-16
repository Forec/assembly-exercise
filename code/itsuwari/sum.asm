TITLE Just sum 3 integers
;
;用汇编语言编写程序，从屏幕上输入三个数，若三个数都不为零，则计算三个数相加的和，并显示在屏幕上，否则在屏幕上显示提示信息“Invalid vote ”，并重新显示等待数据输入的提示信息。输入Q，程序结束。
INTERGER_COUNT = 3

.data
str1 byte "enter a integer:",0
str2 byte "the sum of integers is:",0
str3 byte "Invalid vote", 0
array dword INTERGER_COUNT dup(?)


;************************************************************
;temp:  esi:数组的首地址,长度为4个字节
;           ecx:数组元素个数
;************************************************************
.code
main PROC
    call clrscr
    mov esi,offset array
    mov ecx,INTERGER_COUNT
    call promptforintegers
    call arraysum
    call displaysum
    exit
main ENDP

;-----------------------------------------------
;                   输入数字
;-----------------------------------------------
promptforintegers PROC USES ecx edx esi
    mov edx,offset str1
L1:
    call writestring
    call readint
    call crlf
    mov [esi],eax
    add esi,type dword
    loop L1
    ret
promptforintegers ENDP

;--------------------------------------------------------
;                   求和
arraysum PROC USES esi ecx edx
    mov edx,0
L1:
    add edx,[esi]
    add esi,type dword
    loop L1
    mov eax,edx
    ret
arraysum ENDP
;---------------------------------------------------------

;----------------------------------------------------------
;                   显示和
displaysum PROC USES edx
;----------------------------------------------------------
    mov edx,offset str2
    call writestring
    call writeint
    call crlf
    ret
displaysum ENDP
;----------------------------------------------------------
end main

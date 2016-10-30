title t1_ywt

DATA SEGMENT
ARRAY DW 23, 36, 2, 100, 32000, 54, 0;
ZERO DW ?   
DATA ENDS  

CODE SEGMENT  
START:
    ;; set ZERO in the (1) way 
    mov ax, DATA
    mov ds, ax
    lea bx, ARRAY
    mov WORD PTR [bx+2*7], 0
    
    ;; reset ZERO to 0ffffh
    mov [bx+2*7], 0ffffh;
    
    ;; set ZERO in the (2) way   
    lea bx, ARRAY[2*6]
    mov WORD PTR [bx+2], 0
    
    ;; Back to DOS
    mov ax,4c00h
    int 21h   
          
CODE ENDS          
END START
    
    
       

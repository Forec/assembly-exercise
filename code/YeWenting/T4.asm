TITLE T4_YWT

DATA SEGMENT
    BUFF    DB  1, 2, 3, '123'
    EBUFF   DB  0
    L       EQU EBUFF - BUFF
    ANS     DW  L
ENDS

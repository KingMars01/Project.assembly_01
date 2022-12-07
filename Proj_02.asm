TITLE SUDOKU

.model small
.STACK 100H

    FINALIZA_PROG MACRO ;FINALIZA PROGAMA 
        MOV AH,4CH
        INT 21h
    ENDM 

    P_LINHA MACRO; PULA LINHA
        MOV AH,02
        MOV DL,10
        INT 21h
        MOV DL,13
        INT 21h  
    ENDM 

    PRINT MACRO MSG
        LEA DX,MSG
        MOV AH,09h
	    INT 21h
    ENDM
    
    BARRA2 MACRO; IMPRIMIR "║"
        MOV DL,186
        INT 21h
    ENDM
    
    BARRA1 MACRO; IMPRIMIR "│"
        MOV DL,179
        INT 21h
    ENDM
    
    SPACE MACRO
        MOV DL,32
        INT 21h
    ENDM
    
    IMPMATRIZ MACRO 
        MOV DL,[BX][SI]
        OR DL,30H
        INT 21h
        INC SI 
    ENDM 
    

    PUSHMACRO  MACRO 
        push AX
        push BX
        push CX
        push DX
        push SI   
    ENDM 

    POPMACRO  MACRO 
        pop SI
        pop DX
        pop CX
        pop BX
        pop AX 
    ENDM
 

.data 

LINHA EQU 9

COLUNA EQU 9
  
    FACIL   DB 0,6,0, 5,0,1, 8,0,0
            DB 4,7,3, 0,0,2, 0,0,5
            DB 5,0,1, 0,0,0, 0,2,4
            
            DB 8,1,0, 6,0,0, 0,0,0
            DB 0,9,0, 0,0,0, 0,3,0
            DB 3,5,7, 0,2,0, 6,0,1
            
            DB 0,0,5, 2,0,7, 4,8,0
            DB 9,4,6, 1,0,0, 7,5,0
            DB 0,0,8, 9,0,0, 0,1,0

    FACILR  DB 2,6,9, 5,4,1, 8,7,3
            DB 4,7,3, 8,9,2, 1,6,5
            DB 5,8,1, 3,7,6, 9,2,4
            
            DB 8,1,2, 6,3,9, 5,4,7
            DB 6,9,4, 7,1,5, 2,3,8
            DB 3,5,7, 4,2,8, 6,9,1
            
            DB 1,3,5, 2,6,7, 4,8,9
            DB 9,4,6, 1,8,3, 7,5,2
            DB 7,2,8, 9,5,4, 3,1,6      

    DIFICIL DB 0,0,0, 0,7,0, 9,1,3
            DB 0,0,2, 9,0,0, 6,0,0
            DB 1,0,0, 6,0,0, 0,0,0

            DB 0,0,0, 7,0,0, 5,3,0
            DB 0,3,4, 5,0,0, 0,0,2
            DB 0,8,0, 0,2,0, 0,4,9
            
            DB 0,2,6, 0,0,0, 0,4,0
            DB 8,0,0, 3,0,4, 0,0,0
            DB 0,7,0, 0,0,0, 0,9,1

  DIFICILR  DB 5,6,8, 4,7,2, 9,1,3
            DB 3,4,2, 9,5,1, 6,8,7
            DB 1,9,7, 6,3,8, 2,5,4
            
            DB 2,1,9, 7,4,6, 5,3,8
            DB 7,3,4, 5,8,9, 1,6,2
            DB 6,8,5, 1,2,3, 4,7,9
            
            DB 9,2,6, 8,1,7, 3,4,5
            DB 8,5,1, 3,9,4, 7,2,6
            DB 4,7,3, 2,6,5, 8,9,1

        MSG1 db 10,'            SUDOKU GAME', '$'
        LINHA1 DB ,'----------------------------------------'
 

.CODE 
    MAIN PROC 
        MOV AX,03
        INT 10H

        MOV AX,@DATA
        MOV DS,AX 
        LEA BX,FACIL

        CALL IMPRIME_M

        FINALIZA_PROG

   MAIN ENDP 
   

   IMPRIME_M PROC NEAR 
        
        PUSHMACRO
        
        MOV AH,02
        MOV CX,LINHA
VOLTA:
        MOV DI,3
        XOR SI,SI

    
    P_LINHA
    PRINT LINHA1
    BARRA2
QUADRANTE:
        
        SPACE
        IMPMATRIZ
        SPACE
        BARRA1
        SPACE
        IMPMATRIZ
        SPACE
        BARRA1
        SPACE
        IMPMATRIZ
        SPACE
        BARRA2
        SPACE
        
        DEC DI 
       
        JNZ QUADRANTE
        P_LINHA
        
        ADD BX,COLUNA 

        LOOP VOLTA
         
        POPMACRO
        RET 
        IMPRIME_M ENDP

        CENTER PROC 
        MOV AH,02
        MOV CX,12
        MOV DL,32
        BACK:
        INT 21h
        LOOP BACK
        RET 
        CENTER ENDP




END MAIN
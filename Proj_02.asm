TITLE SUDOKU , Murilo A Croce RA:22002785 , Gustavo Mota RA:22010798

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

    DIVISAOM MACRO ; PULA LINHA + IMPRESSÃO
        MOV AH,09
        LEA DX,DIVISAO
        INT 21h 
                
    ENDM 

    FECHAM MACRO ; IMPRESSAO DE '------'
        
        MOV AH,09
        LEA DX,FECHA
        INT 21h 
                
    ENDM 
    
    SPACE MACRO
        MOV DL,32
        INT 21h
    ENDM

    CLEAN MACRO 
        MOV AX,03
        INT 10H
    ENDM
    
    IMPMATRIZ MACRO 
        MOV DL,[BX][SI]
        OR DL,30H
        INT 21h
        INC SI 
    ENDM  
    
    TABMACRO MACRO 
        MOV AH,02 
        MOV DL,09h
        INT 21h
         
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
 
    COLOR MACRO ;   altera as cores de acordo com bl
        PUSHMACRO
        MOV BL,121 
        XOR BH,BH
        MOV AH,09H
        MOV CX, 1000H
        MOV AL, 20H
        INT 10H
        POPMACRO
    ENDM
    
 
 .data 

LINHA EQU 9
COLUNA EQU 9


FACIL       DB 0,6,0,5,0,1,8,0,0
            DB 4,7,3,0,0,2,0,0,5
            DB 5,0,1,0,0,0,0,2,4          
            DB 8,1,0,6,0,0,0,0,0
            DB 0,9,0,0,0,0,0,3,0
            DB 3,5,7,0,2,0,6,0,1     
            DB 0,0,5,2,0,7,4,8,0
            DB 9,4,6,1,0,0,7,5,0
            DB 0,0,8,9,0,0,0,1,0,'$'

FACILR      DB 2,6,9,5,4,1,8,7,3
            DB 4,7,3,8,9,2,1,6,5
            DB 5,8,1,3,7,6,9,2,4
            DB 8,1,2,6,3,9,5,4,7
            DB 6,9,4,7,1,5,2,3,8
            DB 3,5,7,4,2,8,6,9,1
            DB 1,3,5,2,6,7,4,8,9
            DB 9,4,6,1,8,3,7,5,2
            DB 7,2,8,9,5,4,3,1,6,'$'

MEDIO       DB 1,0,0,0,0,3,2,0,0
            DB 3,0,0,0,0,0,0,5,1
            DB 0,0,0,0,1,0,7,0,0
            DB 0,1,0,6,0,2,0,9,4
            DB 0,9,0,8,0,0,0,0,7
            DB 0,7,2,0,0,0,1,0,3
            DB 0,3,0,0,0,4,9,0,0
            DB 0,8,0,0,0,0,4,0,0
            DB 4,0,9,0,5,0,0,8,2,'$'

MEDIOR      DB 1,5,8,7,6,3,2,4,9
            DB 3,4,7,9,2,8,6,5,1
            DB 9,2,6,4,1,5,7,3,8
            DB 5,1,3,6,7,2,8,9,4
            DB 6,9,4,8,3,1,5,2,7
            DB 8,7,2,5,4,9,1,6,3
            DB 7,3,5,2,8,4,9,1,6
            DB 2,8,1,3,9,6,4,7,5
            DB 4,6,9,1,5,7,3,8,2,'$'

DIFICIL     DB 0,0,0,0,7,0,9,1,3
            DB 0,0,2,9,0,0,6,0,0
            DB 1,0,0,6,0,0,0,0,0
            DB 0,0,0,7,0,0,5,3,0
            DB 0,3,4,5,0,0,0,0,2
            DB 0,8,0,0,2,0,0,4,9            
            DB 0,2,6,0,0,0,0,4,0
            DB 8,0,0,3,0,4,0,0,0
            DB 0,7,0,0,0,0,0,9,1,'$'

DIFICILR    DB 5,6,8,4,7,2,9,1,3
            DB 3,4,2,9,5,1,6,8,7
            DB 1,9,7,6,3,8,2,5,4           
            DB 2,1,9,7,4,6,5,3,8
            DB 7,3,4,5,8,9,1,6,2
            DB 6,8,5,1,2,3,4,7,9          
            DB 9,2,6,8,1,7,3,4,5
            DB 8,5,1,3,9,4,7,2,6
            DB 4,7,3,2,6,5,8,9,1,'$'

MSG1    DB     '                  SUDOKU GAME ',10,'$'
MSG2    DB 10, '        SELECIONE A DIFICULDADE:','$'
MSG3    DB 10, '        FACIL(1) MEDIO(2) DIFICIL(3)','$'
MSG4    DB 10, '================================================================================', '$'

MSG7    DB     '         DIGITE A LINHA  :','$'
MSG8    DB     '         DIGITE A COLUNA :','$'
MSG9    DB     'DIGITE O NUMERO DE 1 A 9 :','$'
MSG10   DB     'CORRETO','$'
MSG11   DB     'ERRADO, TENTE NOVAMENTE','$'
DIVISAO DB     179,'-------',179,'-------',179,'-------',179,'$'
FECHA   DB     '-------------------------','$'
;REGRAS  db 10,'                                  REGRAS'
;         db 10,10,'                       Somente numeros entre 1 e 9'
;            db 10,'                    O Sudoku eh composto por 9x9 espacos'
;           db 10,'             O jogo termina quando todas as posicoes forem preenchidas'
;           db 10,'              Cada quadrante 3x3 deve conter apenas numeros distintos'
;           db 10,'                 Cada coluna deve conter apenas numeros distintos'
;           db 10,'                 Cada linha deve conter apenas numeros  distintos','$'

.CODE 
MAIN PROC 

        MOV AX,@DATA
        MOV DS,AX 
        MOV ES,AX
        
        CLEAN
        COLOR
        CALL DIFICULDADE
        CALL IMPRIME
        TOPO:
        CALL JOGO
        CALL CONFERE_TUDO
        JMP TOPO

   MAIN ENDP 
DIFICULDADE PROC 
    DENOVO:
    PRINT MSG2
    PRINT MSG3
    P_LINHA
    MOV AH,01
    INT 21H 
    MOV CL,AL
    SUB CL,30H
    CMP CL,1
    JZ PULA4 
    CMP CL,2
    JZ PULA5
    CMP CL,3
    JZ PULA6
    JMP DENOVO
    PULA4:
    LEA BX,FACIL
    JMP FIM1
    PULA5:
    LEA BX,MEDIO
    JMP FIM2
    PULA6:
    LEA BX,DIFICIL
    JMP FIM3 
    FIM1:
    FIM2:
    FIM3:
    
    RET 
    DIFICULDADE ENDP

IMPRIME PROC 
        PUSHMACRO
        CLEAN 
        COLOR
        PRINT MSG4
        P_LINHA
        
        MOV AH,02
        MOV CX,LINHA
        
        CALL FECHAP
        CALL SUDOKU
        
    VOLTA:
        MOV DI,3
        XOR SI,SI  
    TABMACRO
    BARRA1
    QUADRANTE:
        
        SPACE
        IMPMATRIZ
        SPACE 
        IMPMATRIZ
        SPACE
        IMPMATRIZ
        SPACE
        BARRA1
                 
        DEC DI   
        JNZ QUADRANTE
        P_LINHA
        
        CALL BARRA
        ADD BX,COLUNA 
        LOOP VOLTA
        CALL FECHAP
         
        P_LINHA
        PRINT MSG4
        POPMACRO
        RET 
    IMPRIME ENDP

JOGO PROC 
    CMP CL,1
    JZ PULA7
    CMP CL,2
    JZ PULA8
    CMP CL,3
    JZ PULA9
    PULA7:
    CALL ENTRADA_F
    CALL CONFERE_F
    PULA8:
    CALL ENTRADA_M
    CALL CONFERE_M
    PULA9:
    CALL ENTRADA_D
    CALL CONFERE_D
    RET
JOGO ENDP

ENTRADA_F PROC 
        PUSHMACRO
        P_LINHA
        PRINT MSG7
        MOV BX,LINHA            ;ENTRADA DA LINHA
        MOV AH,01
        INT 21H 
        XOR AH,AH
        AND AL,0FH
        MUL BX 
        SUB AX,9
        MOV BX,AX
        P_LINHA
        PRINT MSG8
        MOV AH,01               ;ENTRADA DA COLUNA
        INT 21H 
        XOR AH,AH
        AND AL,0FH 
        SUB AL,1  
        MOV SI,AX
        P_LINHA
        PRINT MSG9
        MOV AH,01               ;ENTRADA DO DIGITO
        INT 21H 
        XOR AH,AH
        AND AL,0FH   
        
        MOV FACIL[BX][SI],AL    ;TROCANDO 0 PELO NUMERO DIGITADO
        POPMACRO

    RET 
ENTRADA_F ENDP

ENTRADA_M PROC 
        PUSHMACRO
        P_LINHA
        PRINT MSG7
        MOV BX,LINHA            ;ENTRADA DA LINHA
        MOV AH,01
        INT 21H 
        XOR AH,AH
        AND AL,0FH
        MUL BX 
        SUB AX,9
        MOV BX,AX
        P_LINHA
        PRINT MSG8
        MOV AH,01               ;ENTRADA DA COLUNA
        INT 21H 
        XOR AH,AH
        AND AL,0FH 
        SUB AL,1  
        MOV SI,AX
        P_LINHA
        PRINT MSG9
        MOV AH,01               ;ENTRADA DO DIGITO
        INT 21H 
        XOR AH,AH
        AND AL,0FH   
        
        MOV MEDIO[BX][SI],AL    ;TROCANDO 0 PELO NUMERO DIGITADO
        POPMACRO

    RET 
ENTRADA_M ENDP
ENTRADA_D PROC 
        PUSHMACRO
        P_LINHA
        PRINT MSG7
        MOV BX,LINHA            ;ENTRADA DA LINHA
        MOV AH,01
        INT 21H 
        XOR AH,AH
        AND AL,0FH
        MUL BX 
        SUB AX,9
        MOV BX,AX
        P_LINHA
        PRINT MSG8
        MOV AH,01               ;ENTRADA DA COLUNA
        INT 21H 
        XOR AH,AH
        AND AL,0FH 
        SUB AL,1  
        MOV SI,AX
        P_LINHA
        PRINT MSG9
        MOV AH,01               ;ENTRADA DO DIGITO
        INT 21H 
        XOR AH,AH
        AND AL,0FH   
        
        MOV DIFICIL[BX][SI],AL    ;TROCANDO 0 PELO NUMERO DIGITADO
        POPMACRO

    RET 
ENTRADA_D ENDP
CONFERE_F PROC 
        PUSHMACRO
        MOV CL,FACIL[BX][SI]
        CMP CL,FACILR[BX][SI]
        JNZ PULA
        CALL IMPRIME
        PRINT MSG10
        JMP PULA2
        PULA:
        CALL IMPRIME
        PRINT MSG11
        PULA2:
    
        POPMACRO
    RET 
    CONFERE_F ENDP

CONFERE_M PROC 
        PUSHMACRO
        MOV CL,MEDIO[BX][SI]
        CMP CL,MEDIOR[BX][SI]
        JNZ PULAR1
        CALL IMPRIME
        PRINT MSG10
        JMP PULAR2
        PULAR1:
        CALL IMPRIME
        PRINT MSG11
        PULAR2:
    
        POPMACRO
    RET 
    CONFERE_M ENDP

CONFERE_D PROC 
        PUSHMACRO
        MOV CL,DIFICIL[BX][SI]
        CMP CL,DIFICILR[BX][SI]
        JNZ PULAR3
        CALL IMPRIME
        PRINT MSG10
        JMP PULAR4
        PULAR3:
        CALL IMPRIME
        PRINT MSG11
        PULAR4:
    
        POPMACRO
    RET 
    CONFERE_D ENDP
CONFERE_TUDO PROC 
        PUSHMACRO
        MOV CX,9
    VOLTA5:
        MOV DI,COLUNA
        XOR SI,SI  
    COL:
        MOV DH,[BX][SI]
        CMP DH,0
        JZ PULA3
        INC SI 
                 
        DEC DI   
        JNZ COL
        ADD BX,LINHA 
        LOOP VOLTA5
        FINALIZA_PROG

        PULA3:
    RET 
    CONFERE_TUDO ENDP


BARRA PROC 
        PUSHMACRO
        CMP CX,4
        JNZ OUT1 
        TABMACRO
        DIVISAOM
        P_LINHA
        OUT1:
        CMP CX,7
        JNZ OUT2
        TABMACRO
        DIVISAOM
        P_LINHA
        OUT2:
        POPMACRO
        RET 
BARRA ENDP

FECHAP PROC 
    PUSHMACRO 
    TABMACRO
    FECHAM
    POPMACRO 
    RET 
    FECHAP ENDP

SUDOKU PROC 
    PUSHMACRO
    PRINT MSG1
    POPMACRO
    RET 
    SUDOKU ENDP 

END MAIN
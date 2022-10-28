title Murilo A Croce RA:22002785 , Gustavo Mota RA:22010798



.model small
.DATA
  msg1 DB 10,'                               FACA SUA OPERACAO ','$'
  msg2 DB 10,'                        PARA SOMA(+), PARA SUBTRACAO(-)','$'
  msg3 DB 10,'                     PARA MULTIPLICACAO(*), PARA DIVISAO(/)', 10, '$'
  msg4 DB 10,'                                    ', '$'
  msg5 DB '================================================================================', '$'
  msg6 DB 10,10,'                    DESEJA REALIZAR OUTRA OPERACAO? (s/n)', 10,10, '$'
  msg7 DB 10,10,'                           OBRIGADO POR CALCULAR', '$'


.code
   MAIN PROC

   MOV AX, @DATA
   MOV DS, AX

   DNV:

   CALL VISOR

   ;LEITURA  
   MOV AH,01      ;funcao de leitura do primeiro numero
   INT 21H        ;devolve o caractere lido em AL
   MOV bl,AL      ;agora o caractere esta em BH
    
   MOV AH,01      ;PEGA O DIGITO DA CONTA 
   INT 21H
   MOV BH,AL

   MOV AH,01      ;funcao de leitura do segundo numero
   INT 21H        ;devolve o caractere lido em AL
   MOV CL,AL      ;colocando valor de al em cl

   MOV AH,02      ;imprime '='
   MOV DL,61
   INT 21H
      
   CALL SOMA        ;EXECUTA A SOMA 

   CALL SUBTRACAO   ;EXECUTA A SUBTRACAO

   CALL MULT       ;EXECUTA A MULTIPLICACAO

;   JE DVS         ;EXECUTA A DIVISÃO

   ;FINAL
   PERG:

   MOV AH, 09
   MOV DX, OFFSET msg6
   INT 21H

   MOV AH, 09 
   MOV DX, OFFSET msg5
   INT 21H

   MOV AH,01      ;funcao de leitura do segundo numero
   INT 21H

   CMP AL, 73H
   JE DNV

   CMP AL, 6EH
   JNE PERG
   
   MOV AX,3
   INT 10H

   MOV AH, 09
   MOV DX, OFFSET msg7
   INT 21H

   MOV AH,4CH
   INT 21H

main endp

VISOR PROC

   MOV AX,3
   INT 10H

   MOV AH, 09
   MOV DX, OFFSET msg5
   INT 21H

   MOV AH, 09
   MOV DX, OFFSET msg1
   INT 21H

   MOV AH, 09
   MOV DX, OFFSET msg2
   INT 21H

   MOV AH, 09
   MOV DX, OFFSET msg3
   INT 21H

   MOV AH, 09
   MOV DX, OFFSET msg4
   INT 21H

   VISOR ENDP
   

   SOMA PROC

   CMP BH,2BH
   JNE PROX
  
   ADD bl,cl      ;SOMA BL COM CL ( OS NUMEROS )
  
   mov al, bl      ;movendo bl para al
   mov ah,0        ;zerando a primiera parte de ax
   aaa             ;ajusta o conteudo em ax para dois digitos   

   mov bx,ax       ;movendo ax para bx 
   add bh,30h      ;adicionando 30h para imprimir o numero decimal
   add bl,30h      ;adicionando 30h para imprimir o numero decimal

   mov ah,2        ;imprimindo a primeira parte do numero em bh
   mov dl,bh       
   int 21h  

   mov ah,2        ;imprimindo a segunda parte do numero em bl
   mov dl,bl
   int 21h   

   PROX:
   RET

   SOMA ENDP
   
    
   SUBTRACAO PROC
   CMP BH,2DH
   JNE PROX2
   
   SUB BL,30H    ;subtraindo 30h para subtracao acontecer
   SUB CL,30H    ;com numeros decimais

   CMP BL,CL     ;SE BL<CL IRAO TROCAR DE POSICAO
     JA PULA     
     XCHG BL,CL  ;TROCA BL COM CL 
     MOV AH,02  
     MOV DL,45   ;IMPRIME '-'
     INT 21H
  
   PULA:
   SUB BL,CL     ;executa a subtracao

   ADD BL,30H    ;adiciona 30h para imprimir em decimal 

   MOV AH,02     ;imprime o numero em bl
   MOV DL,BL
   INT 21h

   PROX2:
   RET

   SUBTRACAO ENDP
 
   
   MULT PROC
   CMP BH,2AH
   JNE PROX3
   CALL MULTP
   PROX3:
   RET
   MULT ENDP

   MULTP PROC

   SUB BL,30H
   SUB CL,30H

        MOV DH,BL
        
        CMP CL,0
        JE MULT0
        CMP CL,1
        JE MULT1
        CMP CL,2
        JE MULT2
        CMP CL,3
        JE MULT3
        CMP CL,4
        JE MULT4
        CMP CL,5
        JE MULT5
        CMP CL,6
        JE MULT6
        CMP CL,7
        JE MULT7
        CMP CL,8
        JE MULT8
        CMP CL,9
        JE MULT9

        MULT0:
            MOV BL,0
            JMP IMPRIME
        MULT1:
            JMP IMPRIME
        MULT2:
            SHL BL,1           ;BL := BL*2
            JMP IMPRIME
        MULT3:
            SHL BL,1           ;BL := BL*2
            ADD BL,DH          ;BL := BL*3
            JMP IMPRIME
        MULT4:
            SHL BL,2           ;BL := BL*4
            JMP IMPRIME            
        MULT5:
            SHL BL,2           ;BL := BL*2
            ADD BL,DH          ;BL := BL*3
            JMP IMPRIME
         MULT6:
            MOV BH,BL
            SHL BH,1          
            SHL BL,2           ;BL := BL*4
            ADD BL,BH          ;BL ;= BL*6
            JMP IMPRIME    
        MULT7:
            SHL BL,2
            MOV CL,3
            VOLTA7:
            ADD BL,DH
            LOOP VOLTA7
            JMP IMPRIME
        MULT8:
            SHL BL,3           ;AX := AX*8
            JMP IMPRIME
        MULT9:
            SHL BL,3
            ADD BL,DH
            JMP IMPRIME                                                                                              
        
    IMPRIME:
        MOV CL,10
        MOV AL,BL
        XOR AH,AH
        DIV CL
        MOV CL,AL
        MOV BL,AH

        MOV AH,02
        ADD CL,30H
        MOV DL,CL
        INT 21h

        ADD BL,30h
        MOV DL,BL
        INT 21h 
        
        RET
        
        MULTP ENDP
        
 ;   DVS:

;   MOV AH,01      ;funcao de leitura do segundo numero
 ;  INT 21H        ;devolve o caractere lido em AL
 ;  MOV CL,AL      ;colocando valor de al em cl

 ;  MOV AH,02      ;imprime '='
;   MOV DL,61
 ;  INT 21H
 ;  SUB BL,30H
 ;  SUB CL,30H


;        MOV DH,BL
;        
;        CMP CL,0
;        JE DVS0
;        CMP CL,1
;        JE DVS1
;        CMP CL,2
;        JE DVS2
;        CMP CL,3
;        JE DVS3
;        CMP CL,4
;        JE DVS4
;        CMP CL,5
;        JE DVS5
;        CMP CL,6
;        JE DVS6
;        CMP CL,7
;        JE DVS7
;        CMP CL,8
;        JE DVS8
;        CMP CL,9
;        JE DVS9

  end main
title Murilo A Croce RA:22002785 , Gustavo Mota RA:22010798



.model small
.DATA
  msg1 DB 10,'                               FACA SUA OPERACAO ','$'
  msg2 DB 10,'                        PARA SOMA(+), PARA SUBTRACAO(-)','$'
  msg3 DB 10,'                     PARA MULTIPLICACAO(*), PARA DIVISAO(/)', 10, '$'
  msg4 DB 10,'                                    ', '$'
  msg5 DB '================================================================================', '$'
  msg6 DB 10,10,'                     DESEJA REALIZAR OUTRA OPERACAO? (s/n)', 10,10, '$'
  msg7 DB 10,10,'                           OBRIGADO POR CALCULAR',10,10, '$'
  msg8 DB 10,'                       NAO EH POSSIVEL DIVIDIR POR ZERO', '$'


.code
   MAIN PROC

   MOV AX, @DATA
   MOV DS, AX

   DNV:

   CALL VISOR     ;abre o inicio do progama 

   MOV AH,01      ;funcao de leitura do primeiro numero
   INT 21H        ;devolve o caractere lido em AL
   MOV bl,AL      ;agora o caractere esta em BH
    
   MOV AH,01      ;PEGA O DIGITO DA CONTA 
   INT 21H
   MOV BH,AL

   MOV AH,01      ;funcao de leitura do segundo numero
   INT 21H        ;devolve o caractere lido em AL
   MOV CL,AL      ;colocando valor de al em cl

   MOV AH,02         ;imprime '='
   MOV DL,61
   INT 21H

   CALL SOMA         ;EXECUTA A SOMA 

   CALL SUBTRACAO    ;EXECUTA A SUBTRACAO

   CALL MULT         ;EXECUTA A MULTIPLICACAO

   CALL DIVS         ;EXECUTA A DIVISÃO


   ;FINAL
   PERG:

   MOV BH,05H
   INT 10H

   MOV AH, 09
   MOV DX, OFFSET msg6      ;imprime msg6
   INT 21H

   MOV AH, 09 
   MOV DX, OFFSET msg5      ;imprime msg5
   INT 21H

   MOV AH,01                ;LEITURA DE 'S' E 'N'
   INT 21H

   CMP AL,'s'               ;COMPARA SE EH 's'
   JE DNV

   CMP AL, 6EH         
   JNE PERG
   
   MOV AX,3                 ;limpa o console
   INT 10H

   MOV AH, 09
   MOV DX, OFFSET msg7      ;imprime msg7
   INT 21H

   MOV AH,4CH               ;finaliza o progama 
   INT 21H

main endp

   VISOR PROC             ;imprime todas mensagens de entrada

   MOV AX,3               ;limpa o console
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

   RET

   VISOR ENDP
   

   SOMA PROC

   CMP BH,2BH      ;compara bh com digito da conta
   JNE PROX        ;se for diferente de '+' encerra a adicao
  
   ADD bl,cl       ;SOMA BL COM CL ( OS NUMEROS )
  
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

   PROX:           ;finaliza a adicao
   RET

   SOMA ENDP
   
    
   SUBTRACAO PROC
   CMP BH,2DH      ;compara bh com digito '-'
   JNE PROX2       ;se for diferente acaba a subtracao
   
   SUB BL,30H        ;subtraindo 30h para subtracao acontecer
   SUB CL,30H       ;com numeros decimais

   CMP BL,CL        ;SE BL<CL IRAO TROCAR DE POSICAO
     JA PULA     
     XCHG BL,CL     ;TROCA BL COM CL 
     MOV AH,02  
     MOV DL,45      ;IMPRIME '-'
     INT 21H
  
   PULA:
   SUB BL,CL        ;executa a subtracao

   ADD BL,30H       ;adiciona 30h para imprimir em decimal 

   MOV AH,02        ;imprime o numero em bl
   MOV DL,BL
   INT 21h

   PROX2:          ;finaliza a subtracao
   RET

   SUBTRACAO ENDP
 
   
   MULT PROC         ;inicia multiplicacao de verificacao
   CMP BH,2AH        ;compara o digito em bh com '*'
   JNE PROX3         ;se for diferente acaba a mult
   CALL MULTP
   PROX3:
   RET
   MULT ENDP

   MULTP PROC        ;inicia a multiplicacao

   SUB BL,30H        ;retirando 30h para realizar   
   SUB CL,30H        ;contas apenas com os numeros reais

        MOV DH,BL    ;duplicando bl em dh 
        
        CMP CL,0     ;se cl=0 bl*0  
        JE MULT0
        CMP CL,1     ;se cl=1 bl*1
        JE MULT1
        CMP CL,2     ;se cl=2 bl*2
        JE MULT2
        CMP CL,3     ;se cl=3 bl*3
        JE MULT3
        CMP CL,4     ;se cl=4 bl*4
        JE MULT4
        CMP CL,5     ;se cl=5 bl*5
        JE MULT5
        CMP CL,6     ;se cl=6 bl*6
        JE MULT6
        CMP CL,7     ;se cl=7 bl*7
        JE MULT7
        CMP CL,8     ;se cl=8 bl*8
        JE MULT8
        CMP CL,9     ;se cl=9 bl*9
        JE MULT9

        MULT0:
            MOV BL,0
            JMP IMPRIME
        MULT1:
            JMP IMPRIME
        MULT2:
            SHL BL,1           ;2BL := BL*2
            JMP IMPRIME
        MULT3:
            SHL BL,1           ;2BL := BL*2
            ADD BL,DH          ;3BL := BL*2+BL
            JMP IMPRIME
        MULT4:
            SHL BL,2           ;4BL := BL*4
            JMP IMPRIME            
        MULT5:
            SHL BL,2           ;4BL := BL*2
            ADD BL,DH          ;5BL := BL*2+BL
            JMP IMPRIME
         MULT6:
            
            SHL DH,1           ;BL := BL*2
            SHL BL,2           ;BL := BL*4
            ADD BL,DH          ;BL6 ;= BL*4+BL*2
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
        
   DIVS PROC
       
       CMP BH,2FH
       JNE PROX4
       CALL DVS
       PROX4:
       RET
       DIVS ENDP

       DVS PROC

       SUB BL,30H
       SUB CL,30H

       MOV DH,BL
        
       CMP CL,0
       JE DVS0
       CMP CL,1
       JE DVS1
       CMP CL,2
       JE DVS2
       CMP CL,3
       JE DVS3
       CMP CL,4
       JE DVS4
       CMP CL,5
       JE DVS5
       CMP CL,6
       JE DVS6
       CMP CL,7
       JE DVS7
       CMP CL,8
       JE DVS8
       CMP CL,9
       JE DVS9

        DVS0:
            MOV BL,0
            MOV AH, 09
            MOV DX, OFFSET msg8
            INT 21H
            JMP FIM
        DVS1:
            JMP IMPRIMED
        DVS2:
            SHR BL,1          
            JMP IMPRIMED
        DVS3:
            SHL BL,1         
            ADD BL,DH         
            JMP IMPRIMED
        DVS4:
            SHR BL,2           
            JMP IMPRIMED           
        DVS5:
            SHL BL,2         
            ADD BL,DH        
            JMP IMPRIMED
        DVS6:
            MOV BH,BL
            SHR BH,1          
            SHR BL,2           
            SUB BH,BL         
            JMP IMPRIMED    
        DVS7:
            SHL BL,2
            MOV CL,3
            VOLTA77:
            ADD BL,DH
            LOOP VOLTA77
            JMP IMPRIMED
        DVS8:
            SHR BL,3           
            JMP IMPRIMED
        DVS9:
            SHL BL,3
            ADD BL,DH
            JMP IMPRIMED

            IMPRIMED:
            ADD BL,30h
            MOV AH,02
            MOV DL,BL
            INT 21H

            FIM:

            RET 

     DVS ENDP

  end main

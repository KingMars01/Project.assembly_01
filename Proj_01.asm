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
  msg9 DB 10,'                            RESTO: ', '$'
  msg10 DB,', QUOCIENTE: ', '$'


.code
   MAIN PROC

   MOV AX, @DATA  ;inicializacao do data
   MOV DS, AX

   DNV:           ;recomeca o programa

   CALL VISOR     ;abre o inicio do progama 

   MOV AH,01      ;funcao de leitura do primeiro numero
   INT 21H        ;devolve o caractere lido em AL
   MOV bl,AL      ;agora o caractere esta em BH
    
   MOV AH,01      ;pega o digito da conta
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

   PERG:

   MOV AH, 09
   MOV DX, OFFSET msg6      ;imprime msg6
   INT 21H

   MOV AH, 09 
   MOV DX, OFFSET msg5      ;imprime msg5
   INT 21H

   MOV AH,01                ;LEITURA DE 'S' E 'N'
   INT 21H

   CMP AL,'s'               ;COMPARA SE EH 's'
   JE DNV                   ;recomeca o programa

   CMP AL, 6EH              ;compara se eh 'n'
   JNE PERG                 ;se nao for, refaz a pergunta
   
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
   JNE PROX        ;se for diferente de '+' acaba a soma
  
   ADD bl,cl       ;soma bl com cl (os numeros)
  
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
   JNE PROX2       ;se for diferente acaba a subtraçao
   
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
   
   MULT PROC         ;inicia a verificaçao do caractere
   CMP BH,2AH        ;compara o digito em bh com '*'
   JNE PROX3         ;se for diferente acaba a multiplicaçao
   CALL MULTP        ;se for igual, executa a multiplicaçao
   PROX3:
   RET
   MULT ENDP

   MULTP PROC        ;inicia a multiplicacao

   SUB BL,30H        ;retirando 30h para realizar   
   SUB CL,30H        ;contas apenas com os numeros reais

        xor bh,bh       ;agora bx esta com bh e bl corretos
        MOV DX,BX       ;colocando o multiplicando em dx
        MOV BL,CL       ;colocando o multiplicador e bl

        XOR AX, AX    ;produto
        MOV CX, 4     ;contador

        VOLTA:              
            SHR BL, 1     
            JNC FINAL    ;se no resultado de bl nao tiver carry, pula
        
            ADD AX,DX    ;somando o valor de dx ao produto

        FINAL:
            SHL DX, 1    ;multiplica dx por 2
            LOOP VOLTA   ;loop de 8 vezes

        MOV BL,10        ;movendo 10 para bl
        DIV BL           ;dividindo ax por 10
        MOV DL,AL        ;colocando o primeiro digito do resultado em dl
        MOV DH,AH        ;colocando o segundo digito do resultado em dh

        MOV AH, 02       
        ADD DL,30H
        INT 21h          ;impressao do primeiro digito

        MOV DL,DH
        ADD DL,30H
        INT 21H          ;impressao do segundo digito
        
        MULTP ENDP
        
   DIVS PROC
       
       CMP BH,2FH    ;confere se foi digitado '/'
       JNE PROX4     ;se nao acaba a divisao
       CALL DVS      ;se for inicia a dividao
       PROX4:
       RET
       DIVS ENDP

    DVS PROC
       
       XOR BH,BH     ;zerando bh
       
       SUB BL,30H
       MOV AX,BX        ;dividendo
       SUB CL,30H
       MOV BH,CL        ;divisor
        
       CMP CL,00h       ;se o divisor for 0
       JE FIM           ;pula para o final

      MOV CX,9          ;contador de loop       
      XOR BL,BL         ;zerando bl
      XOR DL,DL         ;zerando dl

   DIVIDE:
      SUB AX,BX         ;subtraindo bx de ax
      JGE SALTA         ;se for maior ou igual a ax salta
      ADD AX,BX      
      MOV DH,0
      JMP SALTA1        ;se for menor salta1

   SALTA:
      MOV DH,1          ;quociente

   SALTA1:
      SHL DL,1          ;desloca dl para a esquerda
      OR  DL,DH
      SHR BX,1          ;desloca bx para a direita
      LOOP DIVIDE       ;loop de 9 vezes

        ADD DL,30H
        ADD AL,30H

        MOV CL,DL       ;realocando o quociente para cl
        MOV BL, AL      ;realocando o resto para bl

        MOV AH, 09                
        MOV DX, OFFSET msg9
        INT 21H                   ;impressao da mensagem "resto"

        MOV AH,02 
        MOV DL,BL
        INT 21H                   ;impressao do resto

        MOV AH, 09
        MOV DX, OFFSET msg10
        INT 21H                   ;impressao da mensagem "quociente"

        MOV AH,02 
        MOV DL,CL
        INT 21H                   ;impressao do quociente
        RET
        
    FIM:
       MOV AH, 09                     ;impressão da mensagem
       MOV DX, OFFSET msg8            ;impossivel dividir
       INT 21H                        ;por 0
       RET 

     DVS ENDP

  END MAIN
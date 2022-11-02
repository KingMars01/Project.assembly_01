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

        xor bh,bh       ;agora bx esta com bh e bl corretos
        MOV DX,BX
        MOV BL,CL 

        XOR AX, AX    ;PRODUTO
        MOV CX, 8     ;CONTADOR

        ;CALL MULT

        VOLTA:    
            SHR BL, 1
            JNC FINAL
        
            ADD AX,DX

        FINAL:
            SHL DX, 1    
            LOOP VOLTA
        MOV BL,10
        DIV BL
        MOV DL,AL
        MOV DH,AH

        MOV AH, 02
        ADD DL,30H
        INT 21h

        MOV DL,DH
        ADD DL,30H
        INT 21H
        
        MULTP ENDP
        
   DIVS PROC
       
       CMP BH,2FH    ;confere se foi digitado '/'
       JNE PROX4     ;se nao acaba a divisao
       CALL DVS     ;se for inicia a dividao
       PROX4:
       RET
       DIVS ENDP

    DVS PROC
       
       XOR BH,BH
       
       SUB BL,30H
       mov AX,bX        ;dividendo
       SUB CL,30H
       mov bh,cl        ;divisor
        
       cmp cl,00h
       JE fim

      mov cx,9          ;contador de loop       
      xor bl,bl
      xor dL,dL
divide:
      sub ax,bx
      jge salta
      add ax,bx
      mov dh,0
      jmp salta1
salta:
      mov dh,1        ;quociente
salta1:
      SHL dl,1
      or  dl,dh
      SHR bx,1
      loop  divide

        ADD DL,30h
        ADD AL,30H

        MOV CL,DL

        MOV AH,02 
        MOV DL,AL
        INT 21H

        MOV AH,02 
        MOV DL,CL
        INT 21H
    fim:
       MOV AH, 09
       MOV DX, OFFSET msg8
       INT 21H
        RET 

     DVS ENDP

  end main

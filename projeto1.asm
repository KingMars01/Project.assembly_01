title Murilo A Croce RA:22002785 , Gustavo Mota RA:22000000



.model small     
.code
   main proc
   
   
   MOV AH,01      ;funcao de leitura do primeiro numero
   INT 21H        ;devolve o caracter lido em AL
   MOV bl,AL      ;agora o caracter esta em BH
    
   MOV AH,01      ;PEGA O DIGITO DA CONTA 
   INT 21H
   
   cmp AL,2BH     ;COMPARA SE O DIGITO EH +
   JE SOMA        ;EXECUTA A SOMA 

   cmp AL,2DH     ;COMPARA SE O DIGITO EH -
   JE SUBTRACAO   ;EXECUTA A SUBTRACAO

   cmp AL,58H     ;COMPARA SE O DIGITO EH X
   JE MULT1       ;EXECUTA A MULTIPLICACAO

   CMP AL,78H     ;COMPARA SE O DIGITO EH x
   JE MULT2       ;EXECUTA A MULTIPLICACAO

   CMP AL,2AH     ;COMPARA SE O DIGITO EH *
   JE MULT3       ;EXECUTA A MULTIPLICACAO

   SOMA:
   MOV AH,01      ;funcao de leitura do segundo numero
   INT 21H        ;devolve o caracter lido em AL
   MOV CL,AL      ;colocando valor de al em cl
  
   ADD bl,cl      ;SOMA BL COM CL ( OS NUMEROS )
          
   MOV AH,02      ;imprime '='
   MOV DL,61
   INT 21H
  
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

   MOV AH,4CH      ;terminando o progama 
   INT 21H
   
    
   SUBTRACAO:
   MOV AH,01      ;funcao de leitura do segundo numero
   INT 21H        ;devolve o caracter lido em AL
   MOV CL,AL      ;colocando valor de al em cl

   MOV AH,02      ;imprime '='
   MOV DL,61
   INT 21H

   SUB BL,30H    ;subtraindo 30h para subtracao acontecer
   SUB CL,30H    ;com numeros decimais

   CMP BL,CL     ;SE BL<CL IRAO TROCAR DE POSICAO
     JA PULA     
     XCHG BL,CL  ;TROCA BL COM CL 
     MOV AH,02  
     MOV DL,45   ;IMPREME '-'
     INT 21H
  
   PULA:
   SUB BL,CL     ;executa a subtracao

   ADD BL,30H    ;adiciona 30h para imprimir em decimal 

   MOV AH,02     ;imprime o numero em bl
   MOV DL,BL
   INT 21h

   MOV AH,4CH    ;termina o progama 
   INT 21h
 
   MULT1:
   MULT2:  
   MULT3:
   
   MOV AH,01      ;funcao de leitura do segundo numero
   INT 21H        ;devolve o caracter lido em AL
   MOV CL,AL      ;colocando valor de al em cl

   MOV AH,02      ;imprime '='
   MOV DL,61
   INT 21H
   




   main endp
  end main
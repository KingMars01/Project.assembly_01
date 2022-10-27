title Murilo A Croce RA:22002785 , Gustavo Mota RA:22010798



.model small
.DATA
  msg1 DB 10,'               FACA SUA OPERACAO ','$'
  msg2 DB 10,'         PARA SOMA(+),PARA SUBTRACAO(-)','$'
  msg3 DB 10,'   PARA MULTIPLICACAO(*, x, X), PARA DIVISAO(/)', 10, '$'
  msg4 DB 10,'DESEJA REALIZAR OUTRA OPERACAO? (s/n)', '$'


.code
   main proc
   
   MOV AX, @DATA
   MOV DS, AX
   MOV AH, 09
   MOV DX, OFFSET msg1
   INT 21H

   MOV AH, 09
   MOV DX, OFFSET msg2
   INT 21H

   MOV AH, 09
   MOV DX, OFFSET msg3
   INT 21H
   
   MOV AH,01      ;funcao de leitura do primeiro numero
   INT 21H        ;devolve o caractere lido em AL
   MOV bl,AL      ;agora o caractere esta em BH
    
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
   INT 21H        ;devolve o caractere lido em AL
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
   INT 21H        ;devolve o caractere lido em AL
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
     MOV DL,45   ;IMPRIME '-'
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
   INT 21H        ;devolve o caractere lido em AL
   MOV CL,AL      ;colocando valor de al em cl

   MOV AH,02      ;imprime '='
   MOV DL,61
   INT 21H
   SUB BL,30H
   SUB CL,30H


   
        MOV DH,BL
        
        CMP CL,0
        JE MUL0
        CMP CL,1
        JE MUL1
        CMP CL,2
        JE MUL2
        CMP CL,3
        JE MUL3
        CMP CL,4
        JE MUL4
        CMP CL,5
        JE MUL5
        CMP CL,6
        JE MUL6
        CMP CL,7
        JE MUL7
        CMP CL,8
        JE MUL8
        CMP CL,9
        JE MUL9

        MUL0:
            MOV BL,0
            JMP IMPRIME
        MUL1:
            JMP IMPRIME
        MUL2:
            SHL BL,1           ;BL := BL*2
            JMP IMPRIME
        MUL3:
            SHL BL,1           ;BL := BL*2
            ADD BL,DH          ;BL := BL*3
            JMP IMPRIME
        MUL4:
            SHL BL,2           ;BL := BL*4
            JMP IMPRIME            
        MUL5:
            SHL BL,2           ;BL := BL*2
            ADD BL,DH          ;BL := BL*3
            JMP IMPRIME
         MUL6:
            MOV BH,BL
            SHL BH,1          
            SHL BL,2           ;BL := BL*4
            ADD BL,BH          ;BL ;= BL*6
            JMP IMPRIME    
        MUL7:
            SHL BL,2
            MOV CL,3
            VOLTA7:
            ADD BL,DH
            LOOP VOLTA7
            JMP IMPRIME
        MUL8:
            SHL BL,3           ;AX := AX*8
            JMP IMPRIME
        MUL9:
            SHL BL,3
            ADD BL,BH
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
       
        MOV AH,4CH      ;terminando o progama
        INT 21H



   main endp
  end main
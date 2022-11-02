.model small
.CODE

    main PROC
        

        MOV DX, 9   ;MULTIPLICANDO
        MOV BL, 9   ;MULTIPLICADOR

        XOR AX, AX      ;PRODUTO
        MOV CX, 8       ;CONTADOR

        VOLTA:    
            SHR BL, 1
            JNC FINAL2
        
            ADD AX,DX

        FINAL2:
            SHL DX, 1
            
        
            LOOP VOLTA
        MOV BL,10
        DIV BL
        MOV DL,AL
        MOV DH,AH

        MOV AH, 02
        OR  DL, 30H
        INT 21h
        MOV DL, DH
        OR DL,30H 
        INT 21H
        MOV AH, 4Ch
        INT 21h
    main ENDP
  END MAIN
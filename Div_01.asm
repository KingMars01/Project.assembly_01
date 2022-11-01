.model small

.code

main proc 
      mov cx,9         ;contador de loop
      mov ax,9         ;dividendo
      mov bh,3         ;divisor
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
      ADD AL,30h

      MOV CL,DL

      MOV AH,02H
      MOV DL,AL
      INT 21H

      MOV DL,CL
      INT 21h

      mov ah,4CH
      int 21H
main endp
end main



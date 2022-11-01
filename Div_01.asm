.model small

.code

main proc 
      mov cx,9
      mov ax,7
      mov bh,2
      xor bl,bl
      xor dL,dL
divide:

      sub ax,bx
      jge salta
      add ax,bx
      mov dh,0
      jmp salta1
salta:
      mov dh,1
salta1:
      shl dl,1
      or  dl,dh
      shr bx,1
      loop  divide
      mov ah,4CH
      int 21H
main endp
end main



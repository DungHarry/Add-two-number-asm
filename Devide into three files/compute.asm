;	Author: Dung Harry
;	Date created: 4th, November 2013

.model small
.stack 100
.data
  tb1 db 10,13,'    Program computing A=B+C'
  tb2 db 10,13,'B=$'
  tb3 db 10,13,'C=$'
  tb4 db 10,13,'The result in decimal A = B + C = $'
  tb5 db 10,13,'The result in binary A= B + C = $'
  a dw ?
  b dw ?
  c dw ?
.code
   inputp   proc
     mov ax,@data
     mov ds,ax
     mov ah,9   ;   print tb1
     lea dx,tb1
     int 21h
     call input10        ;bx holds input number
     mov b,bx    ; store bx to b
     mov ah,9
     lea dx,tb3
     int 21h
     call input10
     mov c,bx    ; Finish inputing c
     mov bx,b
     add bx,c         ;bx=b+c
     mov a,bx
     mov ah,9
     lea dx,tb4
     int 21h
     call out10
     mov ah,9
     lea dx,tb5
     int 21h
     mov ah,2       ; print the result in binary format  ;
     mov dl,10
     
     mov cx,16
     mov ah,2
     loopfc:
        xor dl,dl
        rol bx,1
        adc dl,30h
        int 21h
        loop loopfc
     mov ah,4ch
     int 21h
     inputp  endp

     include out10.asm
     include in10.asm
end inputp























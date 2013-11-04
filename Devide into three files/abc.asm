.model small
.stack 100
.data
  tb1 db 10,13,'    Program computing A=B+C'
  tb2 db 10,13,'            B=$'
  tb3 db 10,13,'            C=$'
  tb4 db 10,13,'        A=B+C=$'
  a dw ?
  b dw ?
  c dw ?
.code
   vaonp   proc
     mov ax,@data
     mov ds,ax
     mov ah,9
     lea dx,tb1
     int 21h
     xor bx,bx   ; bx holds input number
     mov ah,1
     int 21h
     lapw1:
          cmp al,13 ; check for entering
          je  ra1
          and al,0fh
          shl bx,1
          or  bl,al
          int 21h
          jmp lapw1
     ra1: mov b,bx    ; Finish entering b
     mov ah,9
     lea dx,tb3
     int 21h
     xor bx,bx   ; bx holds input number
     mov ah,1
     int 21h
     lapw2:
          cmp al,13 ; Check for entering
          je  ra2
          and al,0fh
          shl bx,1
          or  bl,al
          int 21h
          jmp lapw2
     ra2: mov c,bx    ; Finish entering c
     mov bx,b
     add bx,c         ;bx=b+c
     mov a,bx
     mov ah,9
     lea dx,tb4
     int 21h
     mov cx,16
     mov ah,2
     lapf:
        xor dl,dl
        rol bx,1
        adc dl,30h
        int 21h
        loop lapf
     mov ah,4ch
     int 21h
     vaonp  endp
     end vaonp


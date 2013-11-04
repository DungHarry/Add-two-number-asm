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

;out10 proc

out10 proc
  push ax
  push bx
  push cx
  push dx
  push si
  push di       ;divisor=10
  mov di,10
  test bx,8000h  ;bx<0? zf=0?
  jz output
  mov ah,2
  mov dl,'-'
  int 21h        ;print '-'
  neg bx         ;reverse sign of bx
 output: mov ax,bx ;the dividend bx
       xor cx,cx
    loops: xor dx,dx ; remove high part of divisor
          div di    ; ax= quotient, dx = remaining
          push dx
          inc cx
          cmp ax,0  ; compare quotient with 0?
          jnz loops
  mov ah,2
 loopf: pop dx
       or dl,30h
       int 21h
       loop loopf
  pop di
  pop si
  pop dx
  pop cx
  pop bx
  pop ax
  ret
out10 endp

;input10 proc

input10 proc
  push ax
  push cx
  push dx
  push si
  push di
 input_again:
  xor bx,bx
  mov di,10
  xor ch,ch
  mov si,1
  mov ah,1
  int 21h
  cmp al,'-'
  je asign_negative		;the input number is negative
  cmp al,'+'
  je asign_positive		;the input number is positive
  jmp loopr
 asign_negative: mov si,-1
           int 21h
           jmp loopr
 asign_positive: int 21h
 loopr: cmp al,30h		;convert each number
       jb  input_again
       cmp al,39h
       ja  input_again
       and al,0fh
       mov cl,al
       mov ax,bx
       mul di
       add ax,cx
       mov bx,ax
       mov ah,1
       int 21h
       cmp al,13
       jne loopr
  cmp si,0
  jge end_input
  neg bx
 end_input:
  pop di
  pop si
  pop dx
  pop cx
  pop ax
  ret
input10 endp

end inputp
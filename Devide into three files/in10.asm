;Author: Dung Harry
;Date created: 4th, November 2013


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

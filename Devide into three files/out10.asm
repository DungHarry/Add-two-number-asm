;	Author: Dung Harry
;	Date created: 4th, November 2013

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
  



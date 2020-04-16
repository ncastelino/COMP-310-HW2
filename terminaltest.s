
  section .text   ;

 global _start
 extern main   ; 
 _start:
     call main ;

; puts
;
;  |------------------|
;  |Print string      | <- BP+8
;  |------------------|
;  |Return address    | <- BP+4
;  |------------------|
;  |BP                | <- BP
;  |------------------|

   global puts
puts:
   push ebp
   mov ebp, esp
   pusha

   mov esi, [ebp+8]

puts_loop:
   ; 3. loop: MOV one character from ESI into AL
   mov al, [esi]
   ; 4. CMP the character to 0. If zero, JMP to puts_done
   cmp byte [esi], 0 
   je puts_done
   ; 5. If not zero, push the character onto the stack and CALL putc
   push eax
   call putc
   ; 6. Clean up the stack after returning from the call.
   add esp, 4
   ; 7. JMP back to puts_loop
   add esi, 1
   jmp puts_loop


puts_done:
   popa
   pop ebp
   ret

; putc
;
; Prints a character to terminal. Pass the character to print on the stack.
;
;  |------------------|
;  |Print string      | <- BP+8
;  |------------------|
;  |Return address    | <- BP+4
;  |------------------|
;  |BP                | <- BP
;  |------------------|
;
   global putc
putc:
    push ebp           ; 
    mov ebp,esp
    pusha

    mov ebx, [y_pos]
    mov eax,80
    mul ebx            ; EAX <- multiply y_pos * 80

    add eax, [x_pos]   ; EAX <- then + x_pos
    shl eax,1          ; Mult offset * 2 (size of each character)

    mov esi,0xb8000    ;

    mov cl, [ebp+8]    ; Print character from stack
    and ecx,0xff
    or cx,0x700
    mov [esi+eax],cx
    inc word [x_pos]


    popa               
    pop ebp
    ret

    section .bss    ; Below is data

x_pos:
    dw 0
y_pos:
    dw 0




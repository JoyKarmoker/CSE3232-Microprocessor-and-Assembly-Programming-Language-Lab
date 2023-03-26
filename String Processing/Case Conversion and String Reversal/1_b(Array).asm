.model small
.stack 100H
.data
    input_msg db "Input: $"
    output_msg db "Output: $"
    len dw 0
    array db 100 dup('$')
.code

main proc
    mov ax, @data
    mov ds, ax
    
    ;print input msg
    lea dx, input_msg
    mov ah, 9
    int 21h
    
        
        
    ;loop input
    mov si, 0
    mov ah, 1
    
    WHILE_:
        int 21h
        cmp al, 13
        je END_WHILE
        
        mov array[si], al
        inc si
        inc len
        jmp WHILE_
        
    END_WHILE:
    
    call new_line
    ;print output msg
    
    lea dx, output_msg
    mov ah, 9
    int 21h
    jcxz EXIT ;exit if no characters read
    
    ;loop reverse output
    mov  si, 0
    add  si, len
    dec si
    mov cx, len
    
    output:  
      mov  dl, array[si]
         
      mov  ah, 2
      int  21h
        
      dec  si
      loop  output
    
    
    
    EXIT:
        mov ah, 4ch
        int 21h
main endp

new_line proc
        
       mov ah, 2
       mov dl, 10
       int 21h
       mov dl, 13
       int 21h
       ret      
             
             
new_line endp

end main
       
    
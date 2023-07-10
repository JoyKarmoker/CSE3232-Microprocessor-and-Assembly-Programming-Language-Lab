.model small
.stack 100h
.data
    string db 50 dup(?)
    input_msg db 'Input: $'
    len dw 0
    small_len dw 0
    firstcapital db 90
    lastcapital db 65
    msg1 db 'No Capital in the sentence$'
    msg2 db 'First Capital: $'
    msg3 db 'Last Capital: $'

.code
main proc
    mov ax, data
    mov ds, ax
    
    
    ;input msg print
    lea dx, input_msg
    mov ah, 9
    int 21h
    
    ;loop input
    mov ah, 1
    mov si, 0
    mov len, 0
    
    while:
        int 21h
        cmp al, 13
        je end_while
        
        mov string[si], al
        inc si
        inc len
        jmp while
    
    end_while:
    
    call new_line
    
    ;travarse output
    mov si, 0
    mov cx, len
    mov ah, 2
    mov small_len, 0
    mov firstcapital, 90
    mov lastcapital, 65
    
    traverse_string:
        ;int 21h
        ;mov dl, string[si]
        cmp string[si], 65
        jl increase_small_len
        cmp string[si], 90
        jg increase_small_len
        
        
        mov dl, string[si]
        cmp firstcapital, dl
        jle find_lastcapital
        mov firstcapital, dl
        
        
        find_lastcapital:
            mov dl, string[si]
            cmp lastcapital, dl
            jge next
            mov lastcapital, dl     
        
        jmp next
     
        
        increase_small_len:
            inc small_len
        
        next:
            inc si
            loop traverse_string
        
    
    mov bx, len
    cmp small_len, bx
    je no_capital
    
    
    lea dx, msg2
    mov ah, 9
    int 21h
    mov dl, firstcapital
    mov ah, 2
    int 21h
    call new_line
    
    lea dx, msg3
    mov ah, 9
    int 21h
    mov dl, lastcapital
    mov ah, 2
    int 21h
    call new_line
    
    

         
    
    EXIT:
        mov ah, 4ch
        int 21h
   
   no_capital:
        lea dx, msg1
        mov ah, 9
        int 21h
        jmp EXIT
    
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

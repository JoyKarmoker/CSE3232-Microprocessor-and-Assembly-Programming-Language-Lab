.model small
.stack 100h
.data
    string db 50 dup(?)
    letter db 0
    len dw 0
    longest_sequence dw 0
    index dw 0
    long dw 1
    msg1 db 'Input: $'
    msg2 db 'Longest Sequence length: $'
.code
main proc
    mov ax, @data
    mov ds, ax
    
    lea dx,msg1
    mov ah, 9
    int 21h
    
    mov si, 0
    mov len, 0
    mov ah, 1
    mov cx, 0
    
    while:
        int 21h
        cmp al, 13
        je end_while
        
        mov string[si], al
        inc si
        inc len
        inc cx
        jmp while
    end_while:
    
    
    
    call new_line
    lea dx,msg2
    mov ah, 9
    int 21h
    jcxz EXIT ;if no input is given
    
    mov longest_sequence, 1
    mov long, 1
    mov si, 0
    mov index, 0
    mov dl, string[si]
    mov letter, dl
    inc si
    mov cx, len
    dec cx 
    
    count:
        inc letter
        mov dl, letter
        cmp string[si], dl
        je increase_longest_sequence ;if current alphabet = previous+1 then go to increase_longest_sequence
        mov dl, string[si]
        mov letter, dl
        mov long, 1
        jmp do
        
        increase_longest_sequence:
            inc long
            mov dx, long
            cmp longest_sequence, dx
            jge do
            mov longest_sequence, dx
            mov index, si
            sub index, dx
            inc index
                
        
        
        do:
            inc si
            loop count
    
    
    mov dx, index
    mov si, dx
    mov ah, 2
    mov cx, longest_sequence
    
    output:
        mov dl, string[si]
        int 21h
        inc si
    loop output
    
    
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

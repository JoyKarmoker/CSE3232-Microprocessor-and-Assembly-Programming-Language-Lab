.model small
.stack 100h
.data
    number db ?
    msg1 db 'Give a number of single digit: $'
    msg2 db 'The Given number is even$'
    msg3 db 'The given number is odd$'
.code
main proc
    mov ax, @data
    mov ds, ax
    mov es, ax
    
    lea dx, msg1
    mov ah, 9
    int 21h
    
    mov ah, 1
    int 21h
    sub al, '0'
    
    test al, 1
    je even
    
    odd:
        call new_line
        lea dx, msg3
        mov ah, 9
        int 21h
        jmp exit
    
    even:
        call new_line
        lea dx, msg2
        mov ah, 9
        int 21h
    
    exit:
        mov ah, 4ch
        int 21h
    
main endp

new_line proc
    mov ah, 2
    mov dl, 0ah
    int 21h
    mov dl, 0dh
    int 21h
    ret
new_line endp
end main
.model small
.stack 100h
.data
    num dw ?
    msg1 db 'Give a single digit number: $'
    msg2 db 'The Given number is prime$'
    msg3 db 'The given number is not prime$'
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
    
    mov ah, 0
    mov num, ax
    
    cmp al, 2
    jl not_prime
    
    cmp al, 2
    je prime
    
    cmp al, 3
    je prime
    
    test al, 1 ;if divisble by 2
    je not_prime
    
    mov cx, num
    shr cx, 1 ;divide by 2
    mov bx, 3
    test_prime: 
        cmp bx, cx
        jg prime
        mov ax, num
        div bl
        cmp ah, 0
        je not_prime
        add bl, 2
        jmp test_prime
    
    
    
    prime:
        call new_line
        lea dx, msg2
        mov ah, 9
        int 21h
        jmp exit
    
    
    not_prime:
        call new_line
        lea dx, msg3
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
  

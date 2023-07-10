.model small
.stack 100h
.data
    number db 20 dup(?)
    num dw 0
    msg1 db 'Give a number: $'
    msg2 db 'Summation is: $'
.code
main proc
    mov ax, @data
    mov ds, ax
    mov es, ax
    
    lea dx, msg1
    mov ah, 9
    int 21h
    
    lea di, number
    call read_str
    
    mov cx, bx
    mov al, 0
    mov bl, 10
    conv_number:
        mov dl, number[di]
        inc di
        
        sub dl , '0'
        mul bl
        add al,dl
    loop conv_number
    
    
    mov cx, ax
    mov bx, 1
    sum:
        add num, bx
        inc bx
    loop sum
    
    call new_line
    lea dx, msg2
    mov ah, 9
    int 21h
    
    mov ax, num
    call outdec
    
    exit:
        mov ah, 4ch
        int 21h
    
    
    
    
main endp

read_str proc
    push ax
    push di
    
    mov bx, 0
    cld
    mov ah, 1
    int 21h
    
    take_input:
        cmp al, 0dh
        je read_num_exit
        
        cmp al, 08h
        jne valid_input
        
        dec bx
        dec di
        jmp loop_take_input
        
        valid_input:
            stosb
            inc bx
        loop_take_input:
              int 21h
              jmp take_input
    
    read_num_exit:
        pop di
        pop ax
        ret
    
    
read_str endp


outdec proc
    push ax
    push bx
    push cx
    push dx
    
    or ax, ax
    jne positive ;it it it a postive number
    
    push ax
    mov dl, '-'
    mov ah, 2
    int 21h
    pop ax
    neg ax
    
    positive:  
    mov cx, 0
    mov bx, 10D
    
    repeat:
        
        xor dx, dx
        div bx ;ax quotent, dx remainder
        push dx
        inc cx
        or ax, ax
        jne repeat
        
    mov ah,2
    
    print_loop:
        pop dx
        add dl, 30h
        int 21h
    loop print_loop
        
    
    outdec_exit:
        pop dx
        pop cx
        pop bx
        pop ax
        ret
outdec endp

new_line proc
    mov ah, 2
    mov dl, 0ah
    int 21h
    mov dl, 0dh
    int 21h
    ret
new_line endp


end main

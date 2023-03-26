.model small
.stack 100h
.data
    number_str db 80 dup(?)
    number dw ?
    fact dw 1
    msg1 db 'Give a number: $'
    msg2 db 'The factorial is: $'
.code
main proc
    mov ax, @data
    mov ds, ax
    mov es, ax
    
    lea dx, msg1
    mov ah, 9
    int 21h
    
    lea di, number_str
    call read_str
    
    mov cx, bx 
    mov ax, 0
    mov bx, 10
    
    convert_num:
        mov dl, number_str[di]
        inc di
        sub dl, '0'
        
        mul bl
        add al, dl 
    loop convert_num
    mov number, ax
    cmp number, 0
    je print_dec
    
    mov cx, number
    mov bx, 1
    mov al, 1
    
    factorial:
        mul bl
        inc bl
    loop factorial
    mov fact, ax
    
    print_dec:
    
    call new_line
    lea dx, msg2
    mov ah, 9
    int 21h
    
    mov ax, fact
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
    jne positive
    push ax
    mov dl, '-'
    mov ah, 2
    int 21h
    pop ax
    neg ax
    
    
    positive:
        mov bx, 10
        mov cx, 0
    cal_num:
    
        xor dx, dx
        div bx
        push dx
        inc cx 
        or ax, ax
        jne cal_num
        
    mov ah, 2
    print_num:
        pop dx
        add dl, 30h
        int 21h
    loop print_num
    
    
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
.model small
.stack 100h
.data
    number dw 1289
.code
main proc
    mov ax, @data
    mov ds, ax
    mov ax, 12891
    
    call outdec
    
    exit:
        mov ah, 4ch
        int 21h
    
main endp

outdec proc
    
    push ax
    push bx
    push cx
    push dx
    
    or ax, ax
    jge end_if
    
    push ax
    mov dl, '-'
    mov ah, 2
    int 21h
    pop ax
    neg ax
    
    end_if:
        mov cx, 0
        mov bx, 10
    repeat:
        xor dx, dx
        div bx
        push dx
        inc cx
        
        or ax, ax
        jne repeat
        
        mov ah, 2
    print_loop:
        pop dx
        or dl, 30H
        int 21h
        loop print_loop


    pop dx
    pop cx
    pop bx
    pop ax
    ret
outdec endp
end main
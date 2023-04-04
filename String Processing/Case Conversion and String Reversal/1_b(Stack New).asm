.model small
.stack 100h
.data
    msg1 db 'Give a string input: $'
    msg2 db 'Output is: $'
    string db 80 dup (?)
    str db db 80 dup(?)
    len dw ?
.code
main proc
     mov ax, @data
     mov ds, ax
     mov es, ax
     
     lea dx, msg1
     mov ah, 9
     int 21h
     
     lea di, string
     call read_str
     mov len, bx
     
     mov cx, bx
     lea si, string
     cld
     
     push_to_stack:
        lodsb
        push ax
     loop push_to_stack
     
     mov cx, bx
     lea di, str
     pop_from_stack:
        pop ax
        stosb
     loop pop_from_stack
        
     
     
     
     call new_line
     lea dx, msg2
     mov ah, 9
     int 21h
     
     lea si, str
     mov bx, len
     call print_str
     
     
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
    
    while:
        
        cmp al, 0dh
        je end_while
        
        cmp al, 08h
        jne end_if
        
        dec bx
        dec di
        jmp read
        
        end_if:
            stosb
            inc bx
        
        read:
            int 21h
            jmp while
    end_while:    
    pop di
    pop ax
    ret

read_str endp


print_str proc
    push ax
    push bx
    push cx
    push dx
    push si
    
    cld
    mov cx, bx
    jcxz print_str_exit
    mov ah, 2
    
    print:
        lodsb
        mov dl, al
        int 21h
    loop print
    
    print_str_exit:
        pop si
        pop dx
        pop cx
        pop bx
        pop ax
        ret
    
print_str endp

new_line proc
    mov ah, 2
    mov dl, 10
    int 21h
    mov dl,13
    int 21h
    ret
    
new_line endp

end main
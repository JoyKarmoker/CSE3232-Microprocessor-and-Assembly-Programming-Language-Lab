.model small
.stack 100h
.data
 string db 80 dup(?)
 vowels db 'aeiou'
 consts db 'bcdefghjklmnpqrstvwxyz'
 msg1 db 'Vowels: $'
 msg2 db 'Consts: $'
 vowelct dw 0
 constct dw 0
.code


main proc
    mov ax, @data
    mov ds, ax
    mov es, ax
    
    lea di, string
    call read_str
    
    mov si, di
    cld
    
    
    
    ;after reading bx is the length of strieng read
    repeat:
        lodsb
        
        ;check if it is a vowel
        lea di, vowels
        mov cx, 5
        repne scasb
        jne ck_const
        
        inc vowelct
        jmp until
        
        ck_const:
        lea di, consts
        mov cx, 21
        repne scasb
        jne until
        
        inc constct
        
        until:
            dec bx
            jne repeat
            
      
      call new_line
      lea dx, msg1
      mov ah, 9
      int 21h
      mov ax, vowelct
      call outdec
      
      call new_line
      lea dx, msg2
      mov ah, 9
      int 21h
      mov ax, constct
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


outdec proc
    push ax
    push bx
    push cx
    push dx
    
    or ax, ax
    jge positive
    
    push ax
    mov dl, '-'
    mov ah, 2
    int 21h
    pop ax
    neg ax
    
    positive:
        mov cx, 0
        mov bx, 10
    
    remainder_loop:
        xor dx, dx
        div bx
        push dx
        inc cx
        
        or ax, ax
        jne remainder_loop
    end_remainder_loop:
    
    mov ah, 2
    print_loop:
        pop dx
        or dl, 30h
        int 21h
    
    loop print_loop
    
    
    
    
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
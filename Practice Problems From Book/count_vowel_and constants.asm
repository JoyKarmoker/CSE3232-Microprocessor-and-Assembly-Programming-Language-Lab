.model small
.stack 100h
.data
    string db 80 dup(?)
    vowels db 'aeiou'
    consts db 'bcdfghjklmnpqrstvwxyz'
    vowelct dw 0
    constct dw 0
    msg1 db 'Number of Vowels: $'
    msg2 db 'Number of consts: $'
    
.code
main proc
    
    mov ax, @data
    mov ds, ax
    mov es, ax
    
    lea di, string
    call read_str
    ;after reading bx is the length of the string
    
    mov si, di
    cld
    ;check number of vowels and consts
    
    load_string:
        lodsb ; load from si to al
        
        lea di, vowels
        mov cx, 5 ;number of vowels is 5
        repne scasb
        jne check_const
        
        inc vowelct
        jmp repeat_load_string
        
        check_const:
            lea di, consts
            mov cx, 21
            repne scasb
            jne repeat_load_string
            
            inc constct       
        
        repeat_load_string:
            dec bx
            jne load_string ;if bx is not 0 then again load
            
     
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
    mov ah, 1
    cld
    int 21h
    
    while:
        cmp al, 0dh
        je end_while
        
        cmp al, 08h
        jne read
        
        dec bx
        dec di
        jmp repeat
        
        read:
            stosb
            inc bx
        
        repeat:
            int 21h
            jmp while
    
    
    
    end_while:
    pop di
    pop ax
    ret
    
    
read_str endp
              
disp_str proc
    push ax
    push bx
    push cx
    push dx
    push si
    
    mov cx, bx
    jcxz p_exit
    
    cld
    mov ah, 2
    print_top:
        lodsb
        mov dl, al
        int 21h
    
    loop print_top
    
    p_exit:
    pop si
    pop dx
    pop cx
    pop bx
    pop ax
    
disp_str endp              
              
outdec proc
    push ax
    push bx
    push cx
    push dx
    
    ;first check if it is a negative number
    or ax, ax
    jge positive ;it is positive
    
    push ax
    mov dl, '-'
    mov ah, 2
    int 21h
    pop ax
    neg ax
    
    
    positive:
        mov cx, 0
        mov bx, 10
        
    rept:
        xor dx, dx
        div bx ; quotent in ax, remainder in dx
        push dx
        inc cx
        
        or ax, ax
        jne rept
    
    mov ah, 2
    print_number:
        pop dx
        add dl, 30h
        
        int 21h
    loop print_number
    
        
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
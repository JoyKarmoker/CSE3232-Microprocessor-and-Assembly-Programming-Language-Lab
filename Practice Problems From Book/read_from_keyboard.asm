.model small
.stack 100h
.data

    string db 80 dup(?)
    msg1 db "input: $"
    msg2 db "output: $"
.code
main proc
     mov ax, @data
     mov ds, ax
     mov es, ax
     
     ;read a string
     lea di, string
     call read_str
     
     ;go to new line
     mov ah, 2
     mov dl, 10
     int 21h
     mov dl, 13
     int 21h
     
     
     ;print a string
     lea si, string
     call disp_str
     
     ;dos exit
     mov ah, 4ch
     int 21h
     
    

main endp

read_str proc
    ;input msg
    lea dx, msg1
    mov ah, 9
    int 21h
       
       
       
    push ax
    push di
    cld
    xor bx, bx
    mov ah, 1
    int 21h
    
    while:
        cmp al, 0dh
        je end_while
        
        ;if char is backspace
        cmp al, 08h  ;backspace?
        jne else     ;no, store in string
        
        dec bx    ;yes, decrment char counter
        dec di    ;move str pointer back
        jmp read
        
        else:
            stosb ;read a char into al
            inc bx ;increment char count
        read:
            int 21h
            jmp while
    end_while:
        pop di
        pop ax
        ret    

read_str endp

disp_str proc
    ;output msg
    lea dx, msg2
    mov ah, 9
    int 21h
    
    push ax
    push bx
    push cx
    push dx
    push si
    
    
    mov cx, bx
    jcxz p_exit
    
    cld
    mov ah, 2
    
    top:
        lodsb
        mov dl, al
        int 21h
        loop top
    
    p_exit:
        pop si
        pop dx
        pop cx
        pop bx
        pop ax
        ret
    
disp_str endp


end main
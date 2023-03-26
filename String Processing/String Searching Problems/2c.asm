.model small
.stack 100h
.data
    msg1 db 'Enter sub string: $'
    msg2 db 'Enter main string: $'
    mainst db 80 dup(?)
    subst db 80 dup(?)
    stop dw ?
    start dw ?
    sub_len dw ?
    yesmsg db 'subst is a substring of mainst$'
    nomsg db 'subst is not a substring of mainst$'
.code
main proc
    mov ax, @data
    mov ds, ax
    mov es, ax
    
    mov ah, 9
    lea dx, msg1
    int 21h
    
    lea di, subst
    call read_str
    mov sub_len, bx
    
    call new_line
    
    mov ah, 9
    lea dx, msg2
    int 21h
    
    lea di, mainst
    call read_str
    
    call new_line
    
    or bx, bx
    je no
    cmp sub_len, 0
    je no
    cmp sub_len, bx
    jg no
    
    ;compare strings
    lea si, subst
    lea di, mainst
    cld
    
    mov stop, di
    add stop, bx
    mov cx, sub_len
    sub stop, cx
    
    mov start, di
    
    repeat:
        mov cx, sub_len
        mov di, start
        lea si, subst
        repe cmpsb
        je yes
        
        inc start
        
        mov ax, start
        cmp ax, stop
        jnle no
        jmp repeat
        
        
    
    
    yes:
        lea dx, yesmsg
        jmp display
    no:
        lea dx, nomsg
    display:
        mov ah, 9
        int 21h
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


new_line proc
    mov ah, 2
    mov dl, 0ah
    int 21h
    mov dl, 0dh
    int 21h
    ret
new_line endp

end main
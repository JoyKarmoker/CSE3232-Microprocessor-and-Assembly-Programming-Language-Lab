.model small
.stack 100h
.data
    msg1 db 'Enter subst: $'
    msg2 db 'Enter Mainst: $'
    mainst db 80 dup(?)
    subst db 80 dup(?)
    subst_len dw ?
    start dw ?
    stop dw ?
    yesmsg db 'Subst is a substring of mainst$'
    nomsg db 'Subst is not a substring of mainst$'
.code
main proc
    mov ax, @data
    mov ds, ax
    mov es, ax
    
    ;take subst
    lea dx, msg1
    mov ah, 9
    int 21h
    
    lea di, subst
    call read_str
    mov subst_len, bx ;after reading bx will be the length of subst
    
    ;call new_line
    ;mov cx, bx
    ;jcxz exit
    ;mov si, 0
    ;mov ah, 2
    
    ;print:
        ;mov dl, subst[si]
        ;inc si
        ;int 21h
    ;loop print
    
    call new_line
    ;take mainst
    lea dx, msg2
    mov ah, 9
    int 21h
    
    lea di, mainst
    call read_str
    
    
    ;call new_line
    ;mov cx, bx
    ;jcxz exit
    ;mov si, 0
    ;mov ah, 2
    
    ;print_mainst:
        ;mov dl, mainst[si]
        ;inc si
        ;int 21h
    ;loop print_mainst
    
    
    ; conditions where subst can not be a substring
    or bx, bx
    je no
    cmp subst_len, 0
    je no
    cmp subst_len, bx
    jg no
    
    lea si, subst ;point si to subst
    ;calculating stop
    
    lea di, mainst
    mov stop, di
    add stop, bx
    mov cx, subst_len
    sub stop, cx
    
    mov start, di
    repeat_cmp:
        mov cx, subst_len
        mov di, start
        lea si, subst
        
        repe cmpsb
        je yes
        
        inc start
        
        mov ax, start
        cmp ax, stop
        jnle no
        jmp repeat_cmp
    
    
    yes:
        call new_line
        lea dx, yesmsg
        mov ah, 9
        int 21h
        jmp exit
        
        
    no:
        call new_line
        lea dx, nomsg
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
    
    repeat:
        cmp al, 0dh
        je read_str_exit
        
        cmp al, 08h
        je until
        
        stosb
        inc bx
        jmp loop_repeat
        
        until:
            dec bx
            dec di
        loop_repeat:
            int 21h
            jmp repeat
    
    
    read_str_exit:
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
.model small
.stack 100h
.data
    string db 80 dup(?)
    msg1 db 'Give a input of numbers: $'
    msg2 db 'Sorted: $'
    str_len dw ?
    start dw 0
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
    mov str_len, bx
    
    mov start, 0
    
    outter_loop:
        cmp start, bx
        jge endoutter_loop
        mov si, start
        mov al, string[si]
        mov di, si
        innerloop:
            inc di
            cmp di, bx
            jge end_inner_loop
            
            cmp al, string[di]
            jle continue_inner_loop
            mov al, string[di]
            mov dl, string[si]
            mov string[si], al
            mov string[di], dl
            
            continue_inner_loop:
                jmp innerloop
            
        end_inner_loop:
            inc start
            jmp outter_loop  
    
    endoutter_loop:
    
    call new_line
    lea dx, msg2
    mov ah, 9
    int 21h
    lea si, string
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
    
    take_input:
        cmp al, 0dh
        je read_str_exit
        
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
    
    
    read_str_exit:
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
    mov cx, str_len
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
    mov dl, 0ah
    int 21h
    mov dl, 0dh
    int 21h
    ret
new_line endp

end main

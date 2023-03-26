.model small
.stack 100h
.data
    number db 20 dup(?)
    largest_num db '0'
    msg1 db 'Give an array of number: $'
    msg2 db 'Largest num is: $'
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
    jcxz exit
    lea si, number
    cld
    
    top:
        lodsb
        cmp al, largest_num
        jle end_top
        mov largest_num, al
     end_top:
        loop top
    
    
    call new_line
    lea dx, msg2
    mov ah, 9
    int 21h
    
    mov dl, largest_num
    mov ah, 2
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


new_line proc
    mov ah, 2
    mov dl, 0ah
    int 21h
    mov dl, 0dh
    int 21h
    ret
new_line endp


end main
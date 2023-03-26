.MODEL SMALLL
.STACK 100h
.DATA
    input_msg db "input: $"
    output_msg db "output: $"
.CODE

MAIN PROC
    mov ax, @data
    mov ds, ax
    
    ;input msg print
    lea dx, input_msg
    mov ah, 9
    int 21h
    
    XOR cx, cx ;make cx to zero
    
    ;read a character
    mov ah, 1 ;single character input
    int 21h   ;execute
    
    
    WHILE_:
        cmp al, 0DH ;if entered input is carriege return
        JE END_WHILE
        ;save character on the stack and increment count
        PUSH ax
        INC cx
        
        ;read a character
        INT 21h
        JMP WHILE_  
    END_WHILE:
    
    ;print new line
    MOV ah, 2
    mov dl, 0dh
    INT 21H
    mov dl, 0ah
    INT 21H
    ;JCXZ EXIT   ;exit if no characters read
    JCXZ EXIT
    
    TOP:
        pop dx ;pop a char from stack
        int 21h ; display it
        loop TOP
    
    EXIT:
        mov ah, 4ch
        int 21h
MAIN ENDP
END MAIN
    
    

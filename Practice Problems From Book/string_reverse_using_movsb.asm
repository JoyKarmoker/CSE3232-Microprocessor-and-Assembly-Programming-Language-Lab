.model small
.stack 100h
.data
    string1 db "Hello"
    string2 db 5 dup(?)
    len db 0
    msg db "Reversed string is: $"

.code
main proc
    mov ax, @data
    mov ds, ax
    mov es, ax
    
    mov cx, 5
    std ;direction flag to 1
    lea si, string1+4
    lea di, string2
    
    move:
        movsb
        add di, 2
        loop move
    lea dx, msg
    mov ah, 9
    int 21h
    
    mov cx, 5
    mov ah, 2
    mov si, 0
    output:
        mov dl, string2[si]
        inc si
        int 21h
    loop output
        
    
main endp
end main
.model small
.stack 100h
.data
    string1 db "Hello"
    string2 db 5 dup(?)
    len db 0
    msg db "Copied string is: $"
.code
main proc
    mov ax, @data
    mov ds, ax
    mov es, ax
    mov len, 5
    cld ;set df to 0 for forward processing of string
    lea si, string1
    lea di, string2
    mov cx, 5
    rep movsb
    
    
    lea dx, msg
    mov ah, 9
    int 21h
    
    
    mov cx, 5
    mov si, 0
    mov ah, 2
    print:
      mov dl, string2[si]
      inc si
      int 21h
   loop print
   
   EXIT:
    mov ah, 4ch
    int 21h
        
        
    
main endp
end main
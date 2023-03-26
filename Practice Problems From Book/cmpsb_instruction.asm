.model small
.stack 100h
.data
    string1 db 'ACD'
    string2 db 'ABC'
.code
main proc
    mov ax, @data
    mov ds, ax
    mov es, ax
    cld
    
    lea si, string1
    lea di, string2
    
    cmpsb
    cmpsb
    
    
main endp
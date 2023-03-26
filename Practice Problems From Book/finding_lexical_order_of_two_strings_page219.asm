.model small
.stack 100h
.data
    string1 db 'hello'
    string2 db 'abcd'
.code

main proc
    mov ax, @data
    mov ds, ax
    mov es, ax
    
    mov cx, 10
    lea si, string1
    lea di, string2
    
    repe cmpsb
    jl str1_first
    jg str2_first
    
    mov ax, 0
    jmp exit
    
    str1_first:
        mov ax, 1
        jmp exit
    str2_first:
        mov ax, 2
    exit:
        mov ah, 4ch
        int 21h
    
main endp
end main
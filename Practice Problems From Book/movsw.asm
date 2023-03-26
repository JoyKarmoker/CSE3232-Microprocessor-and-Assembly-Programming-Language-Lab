;example 11.2 page 208
.model small
.stack 100h
.data
    arr dw 10,20,40,50,60, ?
.code
main proc
    mov ax, @data
    mov ds, ax
    mov es, ax
    
    mov cx, 3
    std
    mov si, arr+ 08h
    mov di, arr+ 0ah
    rep movsw
    mov word ptr [di], 30
main endp
end main
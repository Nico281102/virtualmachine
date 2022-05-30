.text 
.p2align 2

.global sum_even_pos
sum_even_pos:

mov w9, #0
mov w10, #0

    cmp w9, w1
    b.ge endwhile
    initiwhile:
    ldr w11, [x0]
    add w10, w10, w11
    add w9, w9, #2 // solo posizioni pari
    add x0, x0, #8 //solo posizioni pari

    cmp w9, w1
    b.lt initiwhile
    endwhile:
    mov w0, w10
    RET


    .global _start
    _start:

    adr x0, ar
    adr x1, len
    ldr w1, [x1]

    BL sum_even_pos

    
    mov x0, #0
    mov x8, #93
    svc #0



    .data
ar: .word 1, -1, 2, -2, 4, -4, 5, -5, 6, -6 // int ar[10] = {1,-1,2,-2,4,-4,5,-5,6,-6};
len: .word 10

        .text 
        .p2align 2
        .global sum_even_odd
        sum_even_odd:
    
    mov w9, #0
    mov w10, #0
    mov w11, #0

        cmp w9, w1
        b.ge endwhile_1
        initwhile_1:
        ldr w12, [x0]
            add w10, w10, w12
            add w9, w9, #2
            add x0, x0, #8

            cmp w9, w1
            b.lt initwhile_1
            endwhile_1:

            mov x15, #0
            add w15, wzr, w9, LSL #2
            sub x0, x0, x15 // reset
            add x0, x0, #4 // v = v+1

            mov w9, #1

        cmp w9, w1
        b.ge endwhile_2
        initwhile_2:
        ldr w12, [x0]
            add w11, w11, w12
            add w9, w9, #2
            add x0, x0, #8

            cmp w9, w1
            b.lt initwhile_2
            endwhile_2:

            str w10, [x2]
            str w11, [x3]

            RET
        .global _start
        _start:

        adr x0, v
        adr x1, len
        ldr w1, [x1]
        adr x2, sum_even
        adr x3, sum_odd

        BL sum_even_odd

        mov x0,#0
        mov x8, #93
        svc #0

            .data
            .p2align 2
v: .word -3,3,-5,5,-4,4
len : .word 6
sum_even: .space 4
sum_odd: .space 4
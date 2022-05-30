        .text
        .p2align 2

        .global remove_neg
        remove_neg:
        mov w9, #0
        mov w10, #0

            cmp w9, w1 
            b.ge endwhile
            initwhile:

            ldr w11, [x0]

                cmp w11, #0
                b.ge endif
                //then
                add w10, w10, w11
                mov w11, #0
                str w11, [x0]
                endif:

                add w9, w9, #1
                add x0, x0, #4

                cmp w9,w1
                b.lt initwhile
                endwhile:

                mov w0, w10
                RET

        .global _start
        _start:
        adr x0, in
        adr x1, len
        ldr w1, [x1]

        BL remove_neg

        mov x0, #0
        mov x8, #93
        svc #0

        .data
        .p2align 2
in: .word 1,-3,4,35, -76
len : .word 5
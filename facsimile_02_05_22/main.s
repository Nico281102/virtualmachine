
        .text
        .p2align 2
        .global foo
        foo:
        mov w9, #0
        mov w10, #0

            cmp w9, w1 
            b.ge endwhile
            initiwhile:

            and w11, w9, #1

            cmp w11, wzr
            b.ne endif
            add w10, w10, #1
            endif:
            add w9, w9, #1

            cmp w9, w1
            b.lt initiwhile
            endwhile:
            mov w0,w9 
            RET


        .global is_palin
        is_palin:
        mov x10, x0
        mov x11, #0
        mov w9, #0
            cmp w9, w1
            b.ge endwhile_1
            initiwhile_1:
            add x0, x0, #1
            
            add w9, w9, #1
            cmp w9, w1 
            b.lt initiwhile_1
            endwhile_1:
            mov w9, #0
            mov x11, x0
            sub x11, x11, #1
            mov x0, x10
                cmp w9, w1
                b.ge endwhile_2
            initwhile_2:
            ldrb w13, [x0]
            ldrb w14, [x11]

                cmp w13, w14
                b.ne return_0
                add w9, w9, #1
                add x0, x0, #1
                sub x11, x11, #1

                cmp w9, w2 
                b.lt initwhile_2
            endwhile_2:
            return_1:
            mov x0, #1
            RET
            return_0:
            mov x0, #0
            RET

    .global _start
    _start:

    adr x0, s
    adr x1, n
    ldr w1, [x1]

    BL is_palin

    mov x0, #0
    mov x8, #93
    svc #0

    .data
    .p2align 2

s: .string "ansnas"
n: .word 6
len : .word 6
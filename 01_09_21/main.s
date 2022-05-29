/*
void low2upp(char *s, int l) {
int i;
char v;
    for (i=0; i < l; i++) {
        v = s[i];
        if (v >= 97 && v <= 122)
            s[i] = v - 32;
    }
}
 */

    .text
    .p2align 2

    .global low2upp
    low2upp:
// Param ( x0: s, w1: l)
    mov w9, #0 // int i = 0

    cmp w9, w1 //if (i >= l) goto endwhile
    b.ge endwhile
    initwhile: 

    ldrb w10, [x0] // v = *s

        cmp w10, 97 //if ( v < 97 ) goto endif
        b.lt endif
        cmp w10, 122 //if (v > 122) goto endif
        b.gt endif

        //than
        sub w10, w10, #32 // v = v - 32
        strb w10, [x0] // s[i] = v

        endif:
        add w9, w9, #1 // ++i
        add x0, x0, #1 // v = v + 1

    cmp w9, w1 // if( i < l) goto initwhile
    b.lt initwhile
    endwhile:

    RET
            .global _start
    _start:
    adr x0, s
    adr x1, len
    ldr x1, [x1]

    BL low2upp


    mov x0, #0
    mov x8, #93
    svc #0


            .data
            .p2align 2
s: .string "CiAo"
len: .word 4
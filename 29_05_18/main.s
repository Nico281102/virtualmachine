/*
Tradurre in assembly MIPS la funzione C:
1. int strncpy(char *dest, char *source, int n) {
2. int i, last;
3. i = 0;
4. do {
5. last = *source;
6. *dest = last;
7. source++;
8. dest++;
9. i++;
10. if (i == n)
11. break;
12. } while (last != 0);
13.
14. return i;
15. } */
        .text
        .p2align 2

        .global strncpy
    strncpy:
// Param: ( x1 = dest, x2 = source , w3 = n)
    mov w9, #0 //int i = 0
    mov w12, #0 // last = '0'

    initwhile:
    ldrb w12, [x2] // last = *source
    strb w12, [x1] // x1 = w12, dest = last
    add x1, x1, #1 //++ source
    add x2, x2, #1 //++ dest 
    add w9, w9, #1 // ++i
    cmp w9, w3 // if( i == n ) goto endif
    b.eq endif
    cmp w12, #0 // if (last != 0) goto initwhile 
    b.ne initwhile
    endwhile:
    endif:
    mov w0, w9 // i = w0
    RET
    
    .global _start
_start:


    adr x1, dest
    adr x2, source
    adr x3, n
    ldr w3, [x3]

    BL strncpy

    mov x0, #0
    mov x8, #93
    svc #0






        .data
        .p2align 2

dest: .space 12
source: .string "ilovecoding"
n: .word 12

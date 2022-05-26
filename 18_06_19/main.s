/*
Considerare la seguente funzione C, il cui risultato deve essere memorizzato nelle ultime due variabili passate per
indirizzo:
void sum_even_odd(int v[], int n, int *sum_even, int *sum_odd) {
int i, t1, t2;
t1 = 0;
    for (i=0; i < n; i=i+2)
        t1 = t1 + v[i];

t2 = 0;
    for (i=1; i < n; i=i+2)    
        t2 = t2 + v[i];

*sum_even = t1;
*sum_odd = t2;
} */

        .text
        .p2align 2
        .global sum_even_odd
    sum_even_odd:
// Param: ( x1 = v w2 = n w3 = sum_even w4 = sum_odd )
// x9 - x15
    mov w9, #0 // int i = 0
    mov w10,#0 // int t1 = 0
    
    cmp w9, w2 // if ( i >= n) goto endwhile_1
    b.ge endwhile_1
        initwhile_1:
        add x14, x1, x9, LSL #2 // x14 = &v[i]
        ldr w13, [x14] // w13 = v[i] 
        add w10, w10, w13 // w10 = w10 + w13
        add w9, w9, #2 // w9+=2
        cmp w9, w2 // if( w9 < w2 ) goto initwhile_1
        b.lt initwhile_1
        endwhile_1:
    mov w9, #1 // int i = 1
    mov w11, #0 // int t2 = 0

    cmp w9, w2 // if( w9 >= w2 ) goto endwhile_2
    b.ge endwhile_2
        initwhile_2:
        add x14, x1, x9, LSL #2 // x14 = &v[i]
        ldr w13, [x14] // w13 = v[i]
        add w11, w11, w13 // w11 = w11 + w13
        add w9, w9, #2// w9 += 2
        cmp w9, w2 // if( i < n ) goto initwhile_2
        b.lt initwhile_2
        endwhile_2:
    str w10, [x3] // *sum_even = t1;
    str w11, [x4] // *sum_odd = t2;
    RET

    .global _start

    _start:
    
    adr x1, v
    adr x2, n
    ldr x2, [x2]
    adr x3, sum_even
    adr x4, sum_odd

    BL sum_even_odd

    mov x0, #0
    mov x8, #93
    svc #0

    .data
    .p2align 2

v: .word 1, -23, 42, -35, 312, 44, -23, 11
n: .word 8
sum_even: .space 4
sum_odd: .space 4






    
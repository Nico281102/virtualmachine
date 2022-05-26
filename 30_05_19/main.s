/*
Tradurre in assembly ARM la funzione C:
void find min(int *v, int n, int *min)
il cui risultato deve essere memorizzato nella variabile min passata per indirizzo.
void find_min(int *v, int n, int *min) {
int i, m;
m = *v;
v = v+1;
    for (i=1; i < n; i++) {
        if (*v < m)
            m = *v;
        v = v+1;
    }
*min = m;
}
 */
        .text
        .p2align 2
        .global find_min
    
    find_min:
    ldr w0, [x1] // w0 = *x1, m = *v
    add x1, x1, #4 // v = v + 1
    mov x9, #0 // int i = 0

        cmp  w9, w2 // if ( x9 >= x2 ) goto endwhile
        b.ge endwhile
        initwhile:
        ldr w10, [x1] // w10 = *x1, w10 = *v
        cmp w10, w0 // if( *v >= m) goto endif 
        b.ge endif
        mov w0, w10 // m = *v
        endif:
        add x1, x1, #4 // v = v + 1

        add w9, w9, #1 // ++i;
        cmp w9, w2 //if ( x9 < x2 ) goto initwhile
        b.lt initwhile
        endwhile:
    str x0, [x3]
    RET

        .global _start
    _start:

    adr x1, v
    adr x2, n
    ldr w2, [x2]
    adr x3, min
    BL find_min


    mov x0, #0
    mov x8, #93
    svc #0





    .data
    .p2align 2

v: .word 1, 3, -7, 23, -89, 245, 3, 0
n: .word 8
min: .space 4 //4 byte di spazio
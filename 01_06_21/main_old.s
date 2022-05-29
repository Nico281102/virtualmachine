/*
void sum_pos_neg(int *v, int n, int *sum_pos, int *sum_neg) {
int i;
int sump, sumn;
if (n == 0) return;
sump = 0;
sumn = 0;
    for (i=0; i < n; i++) {
        if (*v > 0)
            sump += *v;
        if (*v < 0)
            sumn += *v;
        v = v+1;
}
*sum_pos = sump;
*sum_neg = sumn;
} */

/*

x0 = 0
mov w19 #0
mov w20 #0
if( x2 != 0) goto endif
RET
endif:
if(x0 >= x2) goto endwhile
initwhile:
    if(*x1 <= 0) goto endif_1
        w19 = w19 + *x1
    endif_1:
    if(*x1 >= 0) foto endif_2
        w20 = w20 + *x1
    endif_2:
    x1 = x1 + 1

if(x0 < x2 ) goto initwhile
endwhile:
*x3 = w19
*x4 = w20
RET



 */
    .text
    .p2align 2

    .global sum_pos_neg
sum_pos_neg:

    mov x0, #0 //int i = 0
    mov w19, #0 //sump = 0
    mov w20, #0 // sumn = 0
    CMP w2, #0 // if(n!= 0) goto endif
    b.ne endif
    RET
    endif:
    cmp x0, x2 //(if x0 >= x2) goto endwhile
    b.ge endwhile
    initwhile:
    ldr w21, [x1] // w21 = *x1
    cmp w21, #0 // if( x21 < 0) goto endif_1
    b.le endif_1
    add w19, w19, w21 // w19 = w19 + w21
    endif_1:
    cmp w21, #0
    b.ge endif_2
    add w20, w20, w21 // w20 = w20 + w21
    endif_2:
    add x1, x1, #4
    add x0, x0, #1
    cmp x0, x2
    b.lt initwhile

    endwhile:
    str w19, [x3] // *x3 = x19
    str w20, [x4] // *x4 = x20
    RET


    .global _start
_start:

    adr x1, v
    adr x5, len
    ldr w2, [x5]
    adr x3, sum_pos
    adr x4, sum_neg
    str LR, [sp, #-16]!
    BL sum_pos_neg
    ldr LR, [sp], #16
    ldr w24, [x3]
    ldr w25, [x4]

    //fine programma
    mov x0, #0
    mov x8, #93
    svc #0

    .data
    .p2align 2

v: .word 1, -3, 3, 5, -6, 12
len: .word 6 //n
sum_pos: .space 4
sum_neg: .space 4



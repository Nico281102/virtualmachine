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
    .text
    .p2align 2

    .global sum_pos_neg
sum_pos_neg:
// param: ( x0 = v, w1 = n, x2 = sum_pos, x3 = sum_neg)
mov w9, #0 // int i = 0

cmp w1, #0 //if( n == 0) goto return
b.eq return

mov w10, #0 // w10 = 0
mov w11, #0 // w11 = 0

cmp w9, w1 // if( i >= n) goto endwhile
b.ge endwhile
initwhile:
ldr w12, [x0] // w12 = *v


    cmp w12, #0 //if(*v <= 0 ) goto endif_1
    b.le endif_1
    add w10, w10, w12
    endif_1: 

    cmp w12, #0 // if(*v >= 0 ) goto endif_2
    b.ge endif_2
    add w11, w11, w12

    endif_2:

    add x0, x0, #4 // v = v + 1
    add w9, w9, #1
    
    cmp w9, w1 // if( i < n) goto initwhile
    b.lt initwhile
    endwhile:

    str w10, [x2]
    str w11, [x3]

return:
RET

    .global _start
_start:

    adr x0,v
    adr x1, len
    ldr x1, [x1]
    adr x2, sum_pos
    adr x3, sum_neg

    BL sum_pos_neg

    mov x0, #0
    mov x8, #93
    svc #0



    .data
    .p2align 2
v: .word 1, -2, 4, -34
len: .word 4
sum_pos: .space 4
sum_neg: .space 4
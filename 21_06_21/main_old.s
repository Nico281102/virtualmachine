/* 
int ar[10] = {1,-1,2,-2,4,-4,5,-5,6,-6};
int sum_even_pos(int a[], int n) {
int i, acc;
acc = 0;                          w0 = 0 x3 = 0
    for (i=0; i<n; i += 2)        while(x3 < x2 )
        acc += a[i];                w0 = w0 + *(x1+x3*4); ++x3;
    
    return acc;                     RET
}
int main() {
int ret;
ret = sum_even_pos(ar, 10);
printf("%d", ret);
}
*/
    .text //inizio segmento testo
    .p2align 2

    .global _start
_start:

    str LR, [sp, #-16]!
    adr x1, ar 
    adr x5, len
    ldr w2, [x5]
    str x1, [sp, #-16]!
    str w2, [sp, #-16]!
    str x5, [sp, #-16]!
    BL sum_even_pos
    ldr x5, [sp], #16
    ldr w2, [sp], #16
    ldr x1, [sp], #16   
    ldr LR, [sp], #16

    mov x0, #0
    mov x8, #93
    svc #0



    .global sum_even_pos
sum_even_pos:

    mov w0, #0 //acc = 0
    mov x3, #0 // i = 0
    
    cmp x3, x2 // if(x3 >= x2) goto endwhile
    b.ge endwhile
    initwhile:
    add x19, x1, x3, LSL #2 // x19 = &a[i]
    ldr w20, [x19] // w20 = *(x19), w20 = ar[i]
    add w0, w20, w0 // w0 += w20, acc += ar[i]
    add x3, x3, #2 // i+=2

    cmp x3,x2 //if( x3 < x2 ) goto initiwhile
    b.lt initwhile
    endwhile:
    RET 







    .data
    .p2align 2

ar : .word 1,-1,2,-2,4,-4,5,-5,6,-6
len : .word 10
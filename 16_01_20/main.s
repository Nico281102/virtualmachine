/* Considerare la seguente funzione C:
int a[5] = {1,2,3,4,5};
int b[5];
int double_vect(int out[], int in[], int len) {
int i, ret=0;
for (i=0; i < len; i++) {
out[i] = in[i] * 2;
ret += out[i];
}
return(ret);
}
int main() {
int ret;
ret = double_vect(b, a, 5);
....
}
*/
/*
x0 = 0 //ret = 0
x19 = 0 // i = 0
if(x19 >= x3) goto endwhile
initwhile:
x22 = x1 + i
x23 = x2 + i
*(x22) = *(x23)*2
x0 = x0 + x21
x19 = x19 +1
if(x19 < x3 ) goto initwhile
endwhile:
RET
 */
    .text
    .p2align 2

    .global double_vect

double_vect:

    mov x0, #0
    mov x19, #0
    cmp x19, x3 
    b.ge endwhile

    initwhile:
    add x22, x1, x19 ,LSL #2// x22 = &out[i]
    add x23, x2, x19 ,LSL #2 // x23 = &in[i]
    ldr x24, [x23] // x24 = in[i]
    add x24, xzr, x24, LSL #1 // x24 = x24 * 2
    str x24, [x22] // *(x22) = x24
    add x0, x0, x24
    add x19, x19, #1

    cmp x19, x3
    b.lt initwhile
    endwhile:
    RET

    .global _start

_start:
    stp LR, x19, [sp, #-16]!
    stp x22, x23, [sp, #-16]!
    str x24, [sp, #-16]!
    adr x1, b
    adr x2, a
    adr x4, len
    ldr x3, [x4] 
    BL double_vect
    ldr x24, [sp], #16
    ldp x22, x23, [sp], #16
    ldp LR, x19, [sp], #16

    mov x0, #0
    mov x8, #93
    svc #0

    .data
    .p2align 2

a: .word 1, 2, 3, 4, 5
b: .space 20
len: .dword 5
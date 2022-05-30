/*
Considerare la seguente funzione C:
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

        .text
        .p2align 2

        .global double_vect
        double_vect:
        
        // Param: (x0 = out, x1 = in , w2 = len)

        mov w9, #0
        mov w10, #0

        cmp w9, w2 
        b.ge endwhile
        mov w15, #2 // 2 
        initwhile:
        
        ldr w11, [x1]
        mul w11, w11, w15
        str w11, [x0]

        add w10, w10, w11

        add w9, w9, #1
        add x1, x1, #4
        add x0, x0, 4

        cmp w9, w2
        b.lt initwhile

        endwhile:

        mov w0, w10

        RET
        .global _start
        _start:

        adr x0, out
        adr x1, in
        adr x2, len
        ldr w2, [x2]

        BL double_vect

        mov x0, #0
        mov x8, #93
        svc #0


        .data
        .p2align 2

out: .space 16
in: .word 2, -3, 4, -6
len: .word 4 
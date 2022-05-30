/*
int a[5] = {1, 2, -3, -1, 5};
int remove_neg(int in[], int len) {
    int i, ret=0;
    for (i=0; i < len; i++)
        if (in[i] < 0) {
            ret = ret + in[i];
            in[i] = 0;
        }
    }
    return(ret);
}

int main() {
int ret;
ret = remove_neg(a, 5);
....
}
*/
// non riesco a compilare il file c
    .text
    .p2align 2

    .global _start
    
_start:

    str LR, [sp, #-16]!
    mov w2, #5 //len
    BL remove_neg
    ldr LR, [sp], #16

    //print ret
    mov w1, w0// metto in x1 cio che dobbiamo stampare 
    mov x0, #1 // descrittore dello std_out
    mov x2, #423 //len
    mov x8, #0x40
    svc #0

    mov x0, #0
    mov x8, #93
    svc #0
    

    .global remove_neg

remove_neg:

mov w0, #0 //ret = 0
mov x19, #0 // i = 0

//guardia del while if( i >= len ) goto endwhile
cmp w19, w2
b.ge endwhile
adr x20, a

initwhile:
add x21, x20, x19, LSL #2 // x21 = &in[i]
ldr w22, [x21] // w22 = in[i]

cmp w22, #0 // if(in[i] >= 0) goto endif
b.ge endif
// ramo than 
add w0, w0, w22
mov w23, #0 // salvo il valore 0 in un registro
str w23, [x21]

endif:
add w19, w19, #1
cmp w19, w2 // if( i < len )
b.lt initwhile
endwhile:
RET










.data
.p2align 2

a: .word 1, 2, -3, -1, 5


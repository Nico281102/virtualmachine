/* 
int copy(char a[], char b[]) {
int i = 0;
    while (b[i] != 0) {
    a[i] = b[i];
    i++;
    }
a[i] = 0;
return i;
}
 */

    .text
    .p2align 2

    .global copy
    copy:
    // param ( x0 = a, x1 = b)

    mov x9, #0 // int i = 0
    ldrb w10, [x1] // w10 = b[i]
        cmp w10 , #0 // if( b[i] == 0 ) goto endwhile
        b.eq endwhile
        initwhile:
        strb w10, [x0] // a[i] = b [i]

        add x0, x0, #1 // a = a + 1
        add x9, x9, #1 // ++i
        add x1, x1, #1 // b = b + 1
        ldrb w10, [x1] // w10 = b[i]
        
        cmp w10, #0 //if ( b[i] != 0 ) goto initwhile
        b.ne initwhile

        endwhile:

        strb w10, [x0] // a[i] = b [i](0)

        mov x0, x9 //return i
        RET
        
        .global _start
        _start:
        adr x0, a
        adr x1, b

        BL copy

        mov x0, #0
        mov x8, #93
        svc #0

        .data
        .p2align 2
a: .space 5
b: .string "ciao"

/*
void string_print(char *str, int slen) {
int i;
char *p;
p = str;
for (i = 0; i < slen; i++)
print_char(*(p + i));
}
 */

        
       
       .text
       .p2align 2


        .global print_char
    print_char:

    mov x1, x0     //Param x0  = &char 
    mov x0, #1 //descrittore std_out
    mov x2, #1 //byte da stampare
    mov x8, #64
    svc #0
    RET
        .global string_print
        string_print:
    stp x19, x20, [sp, #-16]!
    str LR, [sp, #-16]!

        mov w19, #0 //int i = 0
        mov x20, x0 // x20 = str
        cmp w19, w1
        b.ge endwhile
        initwhile:

        str x0, [sp, #-16]!
        str x1, [sp, #-16]!
        mov x0, x20 //passaggio parametri

        BL print_char

        ldr x1, [sp], #16
        ldr x0, [sp], #16

        add x20, x20, #1
        add w19, w19, #1 

        cmp w19, w1 
        b.lt initwhile
        endwhile:

    ldr LR, [sp], #16
    ldp x19, x20, [sp], #16

    RET
        .global _start
        _start:
        adr x0, str
        adr x1, len
        ldr w1, [x1]

        BL string_print

        mov x0, #0
        mov x8, #93
        svc #0



        .data
        .p2align 2
    str : .string "ciao\n"
    len: .word 5
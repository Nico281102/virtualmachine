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
        .global string_print
    string_print:
// Param: x1 = str, w2 = slen
    mov x9, #0 // int i = 0
    mov x10, x1 // char* p = str; 

    cmp w9, w2 // if(i >= slen) goto endwhile
    b.ge endwhile

    initwhile:

    add x10, x1, x9

    stp w9, w2, [sp, #-16]! //mi assicuro che non vengano toccati
    stp x10,  x1, [sp, #-16]! //mi assicuro che non vengano toccati
    str LR, [sp, #-16]! //salvo il link register

    BL print_char
    
    ldr LR, [sp], #16 //ripristino il link register
    ldp x10, x1, [sp], #16 //mi assicuro che non vengano toccati (io sono il caller e non posso assumere che non vengano toccati)
    ldp w9, w2, [sp], #16 //mi assicuro che non vengano toccati

    add x9, x9, #1
    cmp w9, w2
    b.lt initwhile
    endwhile:
    RET

        .global print_char
    print_char:
    //Param x1 = &char 
    mov x0, #1 //descrittore std_out
    mov x1, x10 //metto il puntatore alla stringa in x1
    mov x2, #1 //byte da stampare
    mov x8, #64
    svc #0
    RET

        .global _start
    _start:

    adr x1, str
    adr x2, slen
    ldr x2 ,[x2]
    BL string_print

    mov x0, #0
    mov x8, #93
    svc #0


    .data
    .p2align 2

str: .string "stringa\n"
slen: .word 8
/*
int c = 5;
int main(){
c = 2+3;
printf("C = %d", c);
return 0;
}*/
    .cpu cortex-a53
    .text
    .p2align 2
    .global _start
_start:

    /*
    mov x0, #5
    str x0, [SP, #-16]! //modifico SP, push 5 nello stack
    str x0, [SP, #-16] //, non modifico SP, push 5 nello stack
    str x0, [SP], #-16  push 5 nello stack, modifico SP
    */
    
    mov x0, #1 //descrittore dello std_out
    adr x1, c // metto il puntatore a c in x0
    ldr x3, [x1] // carico il valore puntato da x1 in x3
    mov x4, #2
    add x3, x4 , #5 // 2 + 5 */
    str x3, [x1]
    mov x2, #4 // carico la len da stampare
    mov x8, #0x40 //chiamo la write
    svc #0

    mov x0, #0
    mov x8, #93
    svc #0


    .data
    c: .word 5
    Fuck: .string "Fuck"
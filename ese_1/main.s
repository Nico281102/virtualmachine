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

    adr x0, c // metto il puntatore a c in x0
    ldr x1, [x0] // carico il valore puntato da x0 in x1
    ADD x0, x0, #2 // 5+2
    mov x8, #64 
    svc #0

    mov x0, #0
    mov x8, #93
    svc #0


    .data
    c: .word 5
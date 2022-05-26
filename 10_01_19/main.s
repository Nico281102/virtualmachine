/*
int copy(char a[], char b[]) {
int i = 0;
while (b[i] != 0) {
a[i] = b[i];
i++;
}
a[i] = 0;
return i;
} */

/*
copy:
x19 = 0 
while(x2[x19] != #0){
    x1[x19] = X2[x19]     
x19++
}
 */

    .text
    .p2align 2
    .global copy

copy:

stp x19, x21 ,[sp, #-16]!
stp x22, x23 ,[sp, #-16]!
mov x19, #0
ldrb w23, [x2]
cmp w23 , #0
b.eq endwhile
initwhile:
add x21, x1 , x19//, LSL #2 // x21 = x1 + (x19*4)
add x22, x2 , x19//, LSL #2 // x22 = x2 + (x19*4)
ldrb w23, [x22]
strb w23, [x21]

add x19, x19, #1 // i+=1
cmp w23, #0
b.ne initwhile
endwhile:
ldp x22 , x23 ,[sp], #16
ldp x19 , x21 ,[sp], #16

RET 

    .global _start
_start:

adr x1, a
adr x2, b
//str x1, [x7]b 
//str x2, [x6]
str LR, [sp, #-16]!
BL copy
ldr LR, [sp], #16
//str x1, [x7]
//str x2, [x6]

mov x0, #0
mov x8, #93
svc #0


    .data
    .p2align 2

a: .string "ilovecoding" 
b: .string "keepcalmandcode"


/*Tradurre in assembly ARM la seguente funzione low2upp che prende in input una stringa s di lunghezza l, e sostituisce tutte
le lettere minuscole in maiuscole.
Nota che 97 `e il codice ASCII di ’a’ e 122 il codice di ’z’, mentre 32 `e la costante da sottrarre per trasformare minuscole in
maiuscole.
void low2upp(char *s, int l) {
int i;                            
char v;                              x0 = 0
    for (i=0; i < l; i++) {          while( x0 < x3){
        v = s[i];                     x2 = *(x4 + i)
        if (v >= 97 && v <= 122)        if( v < 97 || v > 122) goto endif
            s[i] = v - 32;               else *(x4+1) = x2 -32;
    }                                   }
}

1. Tradurre in assembly ARM, usando $s0 per la variabile char v (in verit`a, il byte meno significativo del registro).*/
   .global _start
_start:
    
    BL low2upp
    BL print_string
    mov x0, #0
    mov x8, #93
    svc #0
   
   
   
    .global low2upp
low2upp:
    movz x1, #0 //int i = 0;
    
    adr x6, l
    ldr x6, [x6]
    cmp x1, x6  //if(i >= l) goto endwhile
    b.ge endwhile

    initwhile:
    adr x2, s // x2= &s
    add x3, x2, x1 // sommo l'offset al puntatore x3 = s+i
    ldr x4, [x3] // x4 = *(x3) v = s[i]
    cmp x4, #97  // if( x4 < 97) goto endif
    b.lt endif
    cmp x4, #122 // if(x3 > 122) goto endif
    b.gt endif
    sub x4, x4, #32 // v = v- 32
    str x4, [x3] // s+i = vl    
    add x1, x1, #1
    endif:
    cmp x1, x6
    b.ge endwhile
    endwhile:
    RET

    .global print_string

print_string:
mov x0, #1 //descrittore dello std_out
adr x1, s // metto in x1 il puntatore alla stringa
mov x2, #12 // metto in x2 la len della stringa
mov x8, #0x40 //chiama la write, x8 è il registro per le syscall /*0x40 <=> 64 , 64 <=> 0100 0000 <=> 40 */
svc #0

.data
s: .string "stringa"
l: .word 7
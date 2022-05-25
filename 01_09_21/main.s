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
   
   // callee saved: x19 - x27
   // caller saved: x0  - x15
   
// Corretto il salvataggio del LR?
// Come si utilizza l'AND logico?
// Differenza tra registri callee saved e caller saved?
   
   .global _start
_start:

    //Salvo il LR nello stack
    str LR, [sp, #-16]!
    //chiamo la funzione
    BL low2upp
    //ripristino il LR
    ldr LR, [sp], #16


    //Salvo il LR nello stack
    str LR, [sp, #-16]!
    //chiamo la funzione
    BL print_string
    //ripristino il LR
    ldr LR, [sp], #16


    //fine del programma
    mov x0, #0
    mov x8, #93
    svc #0
   
   
   
    .global low2upp
low2upp:

    movz w1, #0 //int i = 0;
    
    adr x6, len
    ldr w7, [x6] //x7 = *(len)
    cmp w1, w7  //if(x1 >= x7) goto endwhile
    b.ge endwhile

    adr x2, s // x2= s
    initwhile:

    add x3, x2, x1 // sommo l'offset al puntatore x3 = s+i
    ldrb w4, [x3] // w4 = *(x3) v = s[i], carico 1 byte
    cmp w4, #97  // if( w4 < 97) goto endif
    b.lt endif
    cmp w4, #122 // if(w4 > 122) goto endif
    b.gt endif
    sub w4, w4, #32 // v = v - 32
    strb w4, [x3] // s+i = v    
    add w1, w1, #1

    endif:
    cmp w1, w7 // if( w1 < w7 ) goto initwhile
    b.lt initwhile

    endwhile:
    RET



    .global print_string

print_string:

    mov x0, #1 //descrittore dello std_out
    adr x1, s // metto in x1 il puntatore alla stringa
    mov x2, #12 // metto in x2 la len della stringa
    mov x8, #0x40 //chiama la write, x8 è il registro per le syscall /*0x40 <=> 64 , 64 <=> 0100 0000 <=> 40 */
    svc #0
    RET

.data
s: .string "stringa"
len: .word 7
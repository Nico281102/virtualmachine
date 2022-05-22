/* int main(){
    printf("Hello World \n");
    return 0;
} */
    .cpu cortex-a53 //compila per questa CPU

    .text // inizio della sezione testo
    .p2align 2 // le istruzioni si troveranno su inidirizzi multipli di 2^2

    .global _start //il loader sa che deve iniziare da start, dato che è global questa funzione è visibile anche agli altri file  oggetto

_start: 

mov x0, #1 //descrittore dello std_out
adr x1, hello_string // metto in x1 il puntatore alla stringa
mov x2, #12 // metto in x2 la len della stringa
mov x8, #0x40 //chiama la write, x8 è il registro per le syscall /*0x40 <=> 64 , 64 <=> 0100 0000 <=> 40 */
svc #0

//termino il programma
mov x0, #0 //carico il valore di ritorno in x0
mov x8, #93
svc #0


.data //inizio del segmento dati
.p2align 2 // inidirizzo multiplo di 2^2

hello_string: .string "Hello world\n"
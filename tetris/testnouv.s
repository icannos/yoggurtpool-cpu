
#include <brique.s>
#include <graph.sl>
#include <time.s>



#define BLEU 31
#define JAUNE 62430
#define VERT 992
#define ROUGE 64512

leti r0 31
leti r1 22
leti r2 22

leti r3 0
leti r4 0

.carreauto

push 64 r7
call brique.brique
pop 64 r7

jump -13

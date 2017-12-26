
#include <brique.s>
#include <graph.sl>
#include <time.s>
#include <nouvelle.s>
#include <ligne.sl>
#include <collision.s>


#define BORDG 50
#define BORDD 150
#define UNIT 4


#define BLEU 31
#define JAUNE 62430
#define VERT 992
#define ROUGE 64512

.fill 31 80 0 100 10
leti r2 5

push 64 r7
call ligne.effetrepl
pop 64 r7

;.char 31 50 50 ok



jump -13

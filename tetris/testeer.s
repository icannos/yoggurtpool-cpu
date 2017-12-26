#include <graph.sl>
#include <ligne.sl>

#define BORDG 50
#define BORDD 150
#define UNIT 4


leti r2 10

push 64 r7
call ligne.effetrepl
pop 64 r7

jump -13

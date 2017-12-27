#include <graph.sl>
#include <collision.s>


.fill 31 0 0 100 100
leti r0 14
leti r3 0
leti r4 1
leti r1 70
leti r2 50
leti r6 12
push 64 r7
call collision.collision
pop 64 r7

jump -13

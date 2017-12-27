#include <graph.sl>


leti r0 31
leti r1 12
leti r2 18


push 64 r7
call graph.plot
pop 64 r7

leti r1 13

push 64 r7
call graph.estnoir
pop 64 r7

jump -13

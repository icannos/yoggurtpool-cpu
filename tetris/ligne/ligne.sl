jump effetrepl.effetreplskip

effetrepl:

push 64 r0 
push 64 r1 
push 64 r2 
push 64 r3 
push 64 r4 





leti r1 BORDG 

effetrepl.bouclex:
cmpi r1 BORDD 
jumpif z effetrepl.finbouclex
add2i r2 1 
push 64 r7 
call graph.estnoir
pop 64 r7 
sub2i r2 1 
push 64 r7 
sub2i r1 2 
.carreauto 
add2i r1 2 
pop 64 r7 
add2i r1 4 
jump effetrepl.bouclex
effetrepl.finbouclex:


leti r0 0 
leti r1 BORDG 
leti r3 BORDD 
add2i r2 1 
let r4 r2 
add2i r4 4 
push 64 r7 
call graph.fill
pop 64 r7 


pop 64 r4 
pop 64 r3 
pop 64 r2 
pop 64 r1 
pop 64 r0 

return 

effetrepl.effetreplskip:
jump lignepleine.skiplignepleine:



lignepleine:

push 64 r1 
leti r1 BORDG 
add2i r1 2 
leti r0 0 

lignepleine.boucle:
cmpi r1 BORDD 
jumpif gt lignepleine.boucleend
push 64 r7 
call graph.estnoir
pop 64 r7 
cmpi r0 0 
jumpif z lignepleine.nonremplie
add2i r1 4 
leti r0 0 
jump lignepleine.boucle


lignepleine.nonremplie:
leti r0 1 

lignepleine.boucleend:

pop 64 r1 


return 

lignepleine.skiplignepleine:
jump lignevide.skiplignevide:



lignevide:
push 64 r2 
leti r2 124 
push 64 r1 
leti r1 BORDG 
add2i r1 2 

lignevide.boucle:
cmpi r1 BORDD 
jumpif gt lignevide.boucleend
push 64 r7 
call graph.estnoir
pop 64 r7 
cmpi r0 0 
jumpif nz lignevide.nonvide
add2i r1 4 
jump lignevide.boucle


lignevide.nonvide:
leti r0 1 
lignevide.boucleend:

pop 64 r1 
pop 64 r2 

return 

lignevide.skiplignevide:
jump majligne.skipmajligne

majligne:
push 64 r0 
push 64 r1 
push 64 r2 
push 64 r3 
push 64 r4 



leti r2 11 

majligne.boucley:
cmpi r2 125 
jumpif sgt majligne.finboucley
push 64 r7 
call ligne.lignepleine
pop 64 r7 

cmpi r0 0 
jumpif nz majligne.pasremplie
add2i r5 2 
push 64 r0 
push 64 r1 
push 64 r2 
push 64 r3 
push 64 r4 
leti r0 992 
leti r1 13 
let r2 r5 
leti r3 19 
let r4 r5 
add2i r4 2 
push 64 r7 
call graph.fill
pop 64 r7 
pop 64 r4 
pop 64 r3 
pop 64 r2 
pop 64 r1 
pop 64 r0 

push 64 r7 
call ligne.effetrepl
pop 64 r7 


jump majligne.boucley

majligne.pasremplie:
add2i r2 4 
jump majligne.boucley

majligne.finboucley:



pop 64 r4 
pop 64 r3 
pop 64 r2 
pop 64 r1 
pop 64 r0 

return 

majligne.skipmajligne:

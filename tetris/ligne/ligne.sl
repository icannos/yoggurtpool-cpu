jump effetrepl.effetreplskip

effetrepl:

push 64 r0 
push 64 r1 
push 64 r2 
push 64 r3 
push 64 r4 


leti r0 0 
leti r1 BORDG 

leti r3 BORDD 

let r4 r2 
sub2i r4 4 
push 64 r7 
call effetrepl.graph.fill
pop 64 r7 



leti r1 BORDG 

effetrepl.bouclex:
cmpi r1 BORDD 
jumpif z effetrepl.finbouclex
sub2i r2 1 
push 64 r7 
call effetrepl.graph.estnoir
pop 64 r7 
add2i r2 1 
.carreauto 
add2i r1 4 
jump effetrepl.bouclex
effetrepl.finbouclex:


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

lignepleine.boucle:
cmpi r1 BORDD 
jumpif gt lignepleine.boucleend
push 64 r7 
call lignepleine.graph.estnoir
pop 64 r7 
cmpi r0 0 
jumpif z lignepleine.nonremplie
add2i r1 4 
jump lignepleine.boucle


lignepleine.nonremplie:
leti r0 1 
lignepleine.boucleend:

pop 64 r1 


return 

lignepleine.skiplignepleine:
jump lignevide.skiplignevide:



lignevide:

push 64 r1 
leti r1 BORDG 
add2i r1 2 

lignevide.boucle:
cmpi r1 BORDD 
jumpif gt lignevide.boucleend
push 64 r7 
call lignevide.graph.estnoir
pop 64 r7 
cmpi r0 0 
jumpif nz lignevide.nonvide
add2i r1 4 
jump lignevide.boucle


lignevide.nonvide:
leti r0 1 
lignevide.boucleend:

pop 64 r1 


return 

lignevide.skiplignevide:
jump majligne.skipmajligne

majligne:
push 64 r0 
push 64 r1 
push 64 r2 
push 64 r3 
push 64 r4 


leti r2 9 

majligne.boucley:
cmpi r2 127 
jumpif sgt majligne.finboucley
push 64 r7 
call majligne.ligne.lignepleine
pop 64 r7 

cmpi r0 0 
jumpif z majligne.pasremplie
add2i r5 2 
leti r0 992 
leti r1 9 
let r2 r5 
leti r3 13 
let r4 r5 
add2i r4 2 
push 64 r7 
call majligne.graph.fill
pop 64 r7 
push 64 r7 
call majligne.ligne.effetrepl
pop 64 r7 




jump majligne.boucley

majligne.pasremplie:
add2i r2 4 

majligne.finboucley:



pop 64 r4 
pop 64 r3 
pop 64 r2 
pop 64 r1 
pop 64 r0 


majligne.skipmajligne:
['effetrepl', 'lignepleine', 'ligne', 'lignevide', 'majligne']

leti r0 6
leti r1 -8
leti r2 0
#boucle:
cmpi r0 0
jumpif eq #loop
shift right r0 1
jumpif nc #pair
add2 r2 r1
pair:
shift left  r1 1
jump #boucle
#loop:
call -1

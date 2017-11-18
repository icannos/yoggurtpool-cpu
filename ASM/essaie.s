leti r1 0
leti r2 0
leti r0 54


leti r3 1073350080
leti r1 0
boucle:
cmpi r1 327680
jumpif ge #fin
add2 r3 r1
setctr a0 r3
write a0 16 r0
add2i r1 16 
jump #boucle
fin:
jump -13

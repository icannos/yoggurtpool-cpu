leti r0 0
leti r3 1072703332
setctr a1 r3 
write a1 16 r0 
whilebegin35cd75fed5738a: 
leti r0 1072703332
setctr a1 r0 
readse a1 16 r0 
let r1 r0 
leti r0 100

cmp r1 r0 
jumpif ge   elseok35cd75fed574ee
leti r0 1 
jump   ifok35cd75fed574ee
elseok35cd75fed574ee:
leti r0 0 
ifok35cd75fed574ee:
cmpi r0 1 
letiaj r5 whileend35cd75fed5738a
jumpifreg neq r5 
leti r0 1072703332
setctr a1 r0 
readse a1 16 r0 
leti r3 1073343332
setctr a0 r3 
write a0 64 r0 
leti r0 1
leti r3 1073343332
setctr a0 r3 
readze a0 64 r1 
setctr a0 r3 
add2 r0 r1 
leti r3 1072703332
setctr a1 r3 
write a1 16 r0 
letiaj r5 whilebegin35cd75fed5738a
jumpreg r5 
whileend35cd75fed5738a: 
leti r0 1072703332
setctr a1 r0 
readse a1 16 r0 

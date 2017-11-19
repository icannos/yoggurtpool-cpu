leti r0 13
leti r3 1072703332
setctr a1 r3 
write a1 8 r0 
whilebegin35af7cbfe512aa: 
leti r0 1072703332
setctr a1 r0 
readze a1 8 r0 
let r1 r0 
leti r0 100

cmp r1 r0 
jumpif gt #elseok35af7cbfe51364
leti r0 1 
jump #ifok35af7cbfe51364
elseok35af7cbfe51364:
leti r0 0 
ifok35af7cbfe51364:
cmpi r0 1 
jumpif neq #whileend35af7cbfe512aa
leti r0 1
leti r3 1073343332
setctr a0 r3 
write a0 64 r0 
leti r0 1072703332
setctr a1 r0 
readze a1 8 r0 
leti r3 1073343332
setctr a0 r3 
readze a0 64 r1 
setctr a0 r3 
add2 r0 r1 
leti r3 1072703332
setctr a1 r3 
write a1 8 r0 
jump #whilebegin35af7cbfe512aa
whileend35af7cbfe512aa: 
leti r0 1072703332
setctr a1 r0 
readze a1 8 r0
jump -13

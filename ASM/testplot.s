leti r0 65535
leti r1 54
leti r2 55


leti r3 1073350080
sub2i r2 127
shift left r2 9
sub2 r3 r2
shift left r2 2
sub2 r3 r2
sub2i r1 1
shift left r1 4
add2 r3 r1
setctr a0 r3
write a0 16 r0
jump -13

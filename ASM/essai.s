leti r1 0
leti r2 0
leti r0 54
call @plot
jump -13


plot:
shift left r2 7
add2i r2 32
leti r3 1073350080
sub2 r3 r2
add2 r2 r1
setctr a0 r2
write a0 16 r0
return

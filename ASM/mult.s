leti r0 5
leti r1 8

leti r2 0

cmpi r0 0
jumpif eq 11 

and3i r3 r0 1
jumpif z 11
    add2 r2 r1

shift right r0 1
shift left  r1 1
jump 1

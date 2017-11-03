leti r0 17
leti r1 5
leti r2 0
leti r3 5

cmp r1 r0
jumpif slt 22
shift left r1 1
jump -48


cmp r3 r1
jumpif slt 67
shift right r1 1
shift left r2 1
cmp r0 r1
jumpif ge 19
	sub2 r0 r1
	add2i r2 1
jump -93
call -1


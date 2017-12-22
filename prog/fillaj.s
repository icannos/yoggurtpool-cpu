jump prog/plot.s_plotend
prog/plot.s_plot:
push 64 r0 
push 64 r1 
push 64 r2 
push 64 r3 

leti r3 1073350080 
sub2i r2 127 
shift left r2 9 
sub2 r3 r2 
shift left r2 2 
sub2 r3 r2 
shift left r1 4 
add2 r3 r1 
setctr a0 r3 
write a0 16 r0 
return 

pop 64 r3 
pop 64 r2 
pop 64 r1 
pop 64 r0 
prog/plot.s_plotend:
jump prog/plot.s_plotend
prog/plot.s_plot:
push 64 r0 
push 64 r1 
push 64 r2 
push 64 r3 

leti r3 1073350080 
sub2i r2 127 
shift left r2 9 
sub2 r3 r2 
shift left r2 2 
sub2 r3 r2 
shift left r1 4 
add2 r3 r1 
setctr a0 r3 
write a0 16 r0 
return 

pop 64 r3 
pop 64 r2 
pop 64 r1 
pop 64 r0 
prog/plot.s_plotend:

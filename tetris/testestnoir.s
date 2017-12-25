leti r1 12
leti r2 18
call estnoir
jump -13

jump estnoir.skipestnoir

estnoir:
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
readze a0 16 r0 

pop 64 r3 
pop 64 r2 
pop 64 r1 


return 
estnoir.skipestnoir:

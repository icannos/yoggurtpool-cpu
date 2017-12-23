jump skipestnoir
; renvoie dans r0 la couleur du pixel de coordonnees (r1 , r2)
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
skipestnoir:

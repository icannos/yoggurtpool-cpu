leti r0 700010
leti r1 700010
call multeff
jump -13


jump callmultendend
multeff:
    push 64 r0
    push 64 r1

boucle:
    cmpi r0 0
    letiac r5 callmultend
    letiac r6 boucle
    jumpifreg eq r5
    shift right r0 1

    jumpif nc pair
    add2 r2 r1

pair:
    shift left  r1 1

    jumpreg r6

callmultend:

    pop 64 r1
    pop 64 r0

    return

callmultendend:

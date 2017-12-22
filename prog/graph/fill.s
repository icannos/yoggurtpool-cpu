
jump fillskipfill
fill:
push 64 r0
push 64 r1
push 64 r2
push 64 r3
push 64 r4
push 64 r5
push 64 r6

;on choisit la plus petite abscisse
cmp r1 r3
jumpif lt fillechange
let r5 r1
let r1 r3
let r3 r5
fillechange:


;on choisit la plus grande ordonnee
cmp r2 r4
jumpif gt fillechangebis
let r5 r2
let r2 r4
let r4 r5 ; r4 est pour l'instant inutile
fillechangebis:

sub2 r3 r1 ; r3 contient la largeur du rectangle
add2i r3 1
sub3 r5 r2 r4
add2i r5 1; r5 contient le nombre de lignes a tracer (voir si le 1 est utile)
leti r4 160
sub2 r4 r3; r4 contient le nombre de pixels a sauter avant d'ecrire a nouveau
shift left r4 4 ; nombre de bits a sauter

;fin de la preparation calculatoire


;partie mettant dans r6 l'adresse du premier point
leti r6 1073350080
sub2i r2 127
shift left r2 9
sub2 r6 r2
shift left r2 2
sub2 r6 r2
shift left r1 4
add2 r6 r1
setctr a0 r6

fillboucley:
cmpi r5 1 ;on compte le nombre de ligne qui reste a tracer
jumpif slt fillfin
sub2i r5 1

let r1 r3
fillbouclex:
cmpi r3 1 ; on compte le nombre de colonne a remplir
jumpif slt fillfinligne
sub2i r3 1
write a0 16 r0 ; on ecrit la ligne
jump fillbouclex
fillfinligne:
let r3 r1

getctr a0 r6
add2 r6 r4
setctr a0 r6 ; saut de la ligne

jump fillboucley



fillfin:
pop 64 r6
pop 64 r5
pop 64 r4
pop 64 r3
pop 64 r2
pop 64 r1
pop 64 r0

return


fillskipfill:

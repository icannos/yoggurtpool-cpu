leti r0 31; couleur

leti r1 10 ; x1
leti r2 10 ; y1
leti r3 20; x2
leti r4 20; y2

;on choisit la plus petite abscisse
cmp r1 r3
jumpif lt echange
let r5 r1
let r1 r3
let r3 r5
echange:


;on choisit la plus grande ordonnee
cmp r2 r4
jumpif gt echangebis
let r5 r2
let r2 r4
let r4 r5 ; r4 est pour l'instant inutile
echangebis:

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

boucley:
cmpi r5 1 ;on compte le nombre de ligne qui reste a tracer
jumpif slt fin
sub2i r5 1

let r1 r3
bouclex:
cmpi r3 1 ; on compte le nombre de colonne a remplir
jumpif slt finligne
sub2i r3 1
write a0 16 r0 ; on ecrit la ligne
jump bouclex
finligne:
let r3 r1

getctr a0 r6
add2 r6 r4
setctr a0 r6 ; saut de la ligne

jump boucley
fin:
jump -13











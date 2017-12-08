
leti r0 50
leti r1 0
leti r2 0
leti r3 10
leti r4 10

call fill

leti r1 100
leti r2 100
leti r3 69

call putchar

leti r1 100
leti r2 90
leti r3 77

call putchar

leti r1 0
leti r2 70

leti r3 50
leti r4 70

call draw


jump -13


jump drawend
draw:

    push 64 r0
    push 64 r1
    push 64 r2
    push 64 r3
    push 64 r4
    push 64 r5
    push 64 r6

;mettons les points dans le bon sens
cmp r1 r3
jumpif lt echange
let r5 r1
let r1 r3
let r3 r5
let r5 r2
let r2 r4
let r4 r5
echange:

;ceci prepare le premier point
sub3 r5 r3 r1 
shift left r5 1 ;r5 contient dx
sub3 r6 r4 r2
shift left r6 1 ;r6 contient dy
push 64 r1
push 64 r2
push 64 r3
push 64 r7
call plot
pop 64 r7
pop 64 r3
pop 64 r2
pop 64 r1


cmpi r6 0
jumpif slt negatif
cmp r5 r6
jumpif slt grandepente


;on met les donnees dans les bons registres pour ce cas
let r4 r6
sub3 r6 r3 r1

boucle:
cmp r1 r3
jumpif ge fin
add2i r1 1
sub2 r6 r4
cmpi r6 0
jumpif sgt chgmtpixel
add2i r2 1
add2 r6 r5
chgmtpixel:
push 64 r1
push 64 r2
push 64 r3
push 64 r7
call plot
pop 64 r7
pop 64 r3
pop 64 r2
pop 64 r1
jump boucle
fin:

pop 64 r6
pop 64 r5
pop 64 r4
pop 64 r3
pop 64 r2
pop 64 r1
pop 64 r0

return
drawend:

grandepente:
;mettons les bons registres
let r3 r5
let r5 r6
sub3 r6 r4 r2


bouclebis:
cmp r2 r4
jumpif ge finbis
add2i r2 1
sub2 r6 r3
cmpi r6 0
jumpif sgt chgmtpixelbis
add2i r1 1
add2 r6 r5
chgmtpixelbis:
push 64 r1
push 64 r2
push 64 r3
push 64 r7
call plot
pop 64 r7
pop 64 r3
pop 64 r2
pop 64 r1
jump bouclebis
finbis:
pop 64 r6
pop 64 r5
pop 64 r4
pop 64 r3
pop 64 r2
pop 64 r1
pop 64 r0

return


negatif:
push 64 r0
leti r0 0
sub2 r0 r6
cmp r5 r0
jumpif slt grandepentebis
pop 64 r0
;dans le huitieme octant
let r4 r6
sub3 r6 r3 r1

boucleter:
cmp r1 r3
jumpif ge finter
add2i r1 1
add2 r6 r4
cmpi r6 0
jumpif sgt chgmtpixelter
sub2i r2 1
add2 r6 r5
chgmtpixelter:
push 64 r1
push 64 r2
push 64 r3
push 64 r7
call plot
pop 64 r7
pop 64 r3
pop 64 r2
pop 64 r1
jump boucleter
finter:
pop 64 r6
pop 64 r5
pop 64 r4
pop 64 r3
pop 64 r2
pop 64 r1
pop 64 r0

return



grandepentebis:
pop 64 r0
;dans le septieme octant
let r3 r5
let r5 r6
sub3 r6 r4 r2
bouclequater:
cmp r4 r2
jumpif ge finquater
sub2i r2 1
add2 r6 r3
cmpi r6 0
jumpif slt chgmtpixelquater
add2i r1 1
add2 r6 r5
chgmtpixelquater:
push 64 r1
push 64 r2
push 64 r3
push 64 r7
call plot
pop 64 r7
pop 64 r3
pop 64 r2
pop 64 r1
jump bouclequater
finquater:
pop 64 r6
pop 64 r5
pop 64 r4
pop 64 r3
pop 64 r2
pop 64 r1
pop 64 r0

return

jump plotend
plot:
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
plotend:





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






jump skipputchar
putchar:
    push 64 r0
    push 64 r1
    push 64 r2
    push 64 r3
    push 64 r4
    push 64 r5
    push 64 r6
    push 64 r7

    
    ; ===================================================
    
    ; On construit l'adresse du pixel en haut a gauche on le met dans r6
    
    add2i r2 8
    
    leti r4 1073350080
    sub2i r2 127
    shift left r2 9
    sub2 r4 r2
    shift left r2 2
    sub2 r4 r2
    shift left r1 4
    add2 r4 r1
    
    setctr a0 r4
    
    ; ===================================================
    
    ; On construit l'adresse du caractere à lire
    letiac r5 font
    shift l r3 6 ; On multiplie r3 par 64
    add2 r3 r5 ; r3 pointe maintenant vers l'adresse du 1er bit de notre caractere
    
    setctr a1 r3
    
    ; ==================================================== 
    
    ; On construit le saut à réaliser en fin de ligne dans r5
        
    leti r5 152
    shift l r5 4
    
    
    ; ==================================================== 
    
    ; Boucle pour chaque ligne à écrire
    
    leti r1 0
    
    bouclecaraclineback:
    cmpi r1 7    
    jumpif sgt bouclecaracline
        call putlc ; On ecrit une ligne du caractere
        
        ; On saute de 120 pixels
        getctr a0 r2
        add2 r2 r5 ; On ajoute r5 = 120 * 16 dans r2
        setctr a0 r2
        add2i r1 1
    jump bouclecaraclineback    
    bouclecaracline:
    
    pop 64 r7
    pop 64 r6
    pop 64 r5
    pop 64 r4
    pop 64 r3
    pop 64 r2
    pop 64 r1
    pop 64 r0
    
    return
    
    
; ===================================================

; Pour chaque ligne

putlc: 

    push 64 r1
    push 64 r5
    push 64 r6
    
    readze a1 8 r5 ; On lit 8 pixels du caractere ie une ligne    
    leti r1 0
    
    bouclecaracpixback:
    cmpi r1 8
    jumpif sgt bouclecaracpixend
        shift r r5 1        
        jumpif nc caracnowrite ; Si bit = 1 alors on ecrit
            write a0 16 r0        
        jump caracwriteend
        caracnowrite: ; Sinon on ne fait rien et on déplace juste a0
            getctr a0 r6
            add2i r6 16
            setctr a0 r6      
        
        caracwriteend:
        
        add2i r1 1    
    jump bouclecaracpixback
    bouclecaracpixend:
    
    
    pop 64 r6
    pop 64 r5
    pop 64 r1
    
    return
    
    
    

jump endfont
font: ; Binary font
    load font.mem
endfont:

skipputchar:


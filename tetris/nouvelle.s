jump skipnouvelle
nouvelle:

push 64 r7


;on cree les parametres aléatoires qui vont bien

push 64 r7
call -2
pop 64 r7


let r3 r0

push 64 r7
call -2
pop 64 r7

let r4 r0

push 64 r7
call -2
pop 64 r7
;transformons ce nombre en couleur
cmpi r0 0
jumpif nz pasbleu
	leti r0 BLEU
	pasbleu:
cmpi r0 1
jumpif nz pasjaune
	leti r0 JAUNE
	pasjaune:
cmpi r0 2
jumpif nz pasvert
	leti r0 VERT
	pasvert:
cmpi r0 3
jumpif nz pasrouge
	leti r0 ROUGE
	pasrouge:


leti r1 100 ;on met la piece au milieu
leti r2 127


pop 64 r7
return

skipnouvelle:

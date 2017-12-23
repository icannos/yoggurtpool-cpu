jump skipnouvelle
nouvelle:

#define BLEU 31
#define JAUNE 62430
#define VERT 992
#define ROUGE 64512


;on cree les parametres aléatoires qui vont bien
call -2
let r3 r0
call -2
let r4
call -2
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




skipnouvelle:

jump skipmajligne
;nous met a jour l'ensemble des lignes de la grille
majligne:
push 64 r0
push 64 r1
push 64 r2
push 64 r3
push 64 r4


leti r2 9 ; ligne du haut des carres du bas

boucley:
	cmpi r2 127
	jumpif sgt finboucley
	call ligne.lignepleine
		;distinguons les deux cas
		cmpi r0 0
		jumpif z pasremplie
		call ligne.effetrepl

;attention : il faudrait incrémenter score ici

		jump boucley ; on retestera la meme ligne au cas ou plusieurs ligne de suite serait remplie

		pasremplie:
		add2i r2 4 ;on passe à la ligne d'au dessus

finboucley:
	


pop 64 r4
pop 64 r3
pop 64 r2
pop 64 r1
pop 64 r0


skipmajligne:

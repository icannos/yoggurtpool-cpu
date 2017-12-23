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
	push 64 r7
	call ligne.lignepleine
	pop 64 r7
		;distinguons les deux cas
		cmpi r0 0
		jumpif z pasremplie
		add2i r5 2
		leti r0 992
		leti r1 9
		let r2 r5
		leti r3 13
		let r4 r5
		add2i r4 2
		push 64 r7
		call graph.fill
		pop 64 r7
		push 64 r7
		call ligne.effetrepl
		pop 64 r7


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

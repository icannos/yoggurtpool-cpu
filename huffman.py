#tentative de codage de Huffman
from heapq import *

def arbre_huffman(occurrences):
    # Construction d'un tas avec les lettres sous forme de feuilles
    tas = [(occ, lettre) for (lettre, occ) in occurrences.items()]
    heapify(tas)

    # Creation de l'arbre
    while len(tas) >= 2:
        occ1, noeud1 = heappop(tas) # noeud de plus petit poids occ1
        occ2, noeud2 = heappop(tas) # noeud de deuxieme plus petit poids occ2
        heappush(tas, (occ1 + occ2, {0: noeud1, 1: noeud2}))
        # ajoute au tas le noeud de poids occ1+occ2 et avec les fils noeud1 et noeud2

    return heappop(tas)[1]

def code_huffman_parcours(arbre,prefixe,code):
	# construit le code en descendant l'arbre
    for noeud in arbre:
        if len(arbre[noeud]) == 1:
            code[prefixe+str(noeud)] = arbre[noeud]
        else:
            code_huffman_parcours(arbre[noeud],prefixe+str(noeud),code)

def code_huffman(arbre):
	#retourne le codage associe a l'arbre deja construit.
    code = {}
    code_huffman_parcours(arbre,'',code)
    return code


dictionnaire = {'A': 5, 'R': 2, 'B': 2, 'C': 1, 'D': 1}
arbre = arbre_huffman(dictionnaire)
rep =code_huffman(arbre)
print(rep)

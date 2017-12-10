#! /usr/bin/python2


# tentative de codage de Huffman
from heapq import *
import argparse
import re


def arbre_huffman(occurrences):
    # Construction d'un tas avec les lettres sous forme de feuilles
    tas = [(occ, lettre) for (lettre, occ) in occurrences.items()]
    heapify(tas)

    # Creation de l'arbre
    while len(tas) >= 2:
        occ1, noeud1 = heappop(tas)  # noeud de plus petit poids occ1
        occ2, noeud2 = heappop(tas)  # noeud de deuxieme plus petit poids occ2
        heappush(tas, (occ1 + occ2, {0: noeud1, 1: noeud2}))
        # ajoute au tas le noeud de poids occ1+occ2 et avec les fils noeud1 et noeud2

    return heappop(tas)[1]


def code_huffman_parcours(arbre, prefixe, code):
    # construit le code en descendant l'arbre
    for noeud in arbre:
        if len(arbre[noeud]) == 1:
            code[prefixe + str(noeud)] = arbre[noeud]
        else:
            code_huffman_parcours(arbre[noeud], prefixe + str(noeud), code)


def code_huffman(arbre):
    # retourne le codage associe a l'arbre deja construit.
    code = {}
    code_huffman_parcours(arbre, '', code)
    return code


if __name__ == "__main__":
    argparser = argparse.ArgumentParser(description='This is the assembler for the ASR2017 processor @ ENS-Lyon')
    argparser.add_argument('filename',
                           help='path to stats file')

    argparser.add_argument('--output',
                           help='Name and where the output should be put.')

    options = argparser.parse_args()

    f = open(options.filename, "r")

    occurences = {}

    for l in f.readline():
        tokens = re.findall('[\S]+', l)
        occurences[tokens[0]] = int(tokens[1])

    f.close()

    encodage = code_huffman(arbre_huffman(occurences))

    dump = "| Opcode | Mnemonic |\n"
    dump +="| ------ | -------  |\n"

    for k in encodage.keys():
        dump += str(k) + "|" + str(encodage[k]) + "| \n"

    if options.output == None:
        filename, ext = basefilename, extension = os.path.splitext(options.filename)
    else:
        filename = options.output

    f = open(filename, "w")
    f.write(dump)
    f.close()


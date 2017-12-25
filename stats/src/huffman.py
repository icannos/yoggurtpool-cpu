#! /usr/bin/python2


from heapq import *
import os
import argparse
import re


def arbre_huffman(occurrences):
    # Construction d'un tas avec les opcodes sous forme de feuilles
    tas = [(occ, {'opcode': lettre}) for (lettre, occ) in occurrences.items()]
    heapify(tas)

    # Creation de l'arbre
    while len(tas) >= 2:
        occ1, noeud1 = heappop(tas)  # noeud de plus petit poids occ1
        occ2, noeud2 = heappop(tas)  # noeud de deuxieme plus petit poids occ2
        heappush(tas, (occ1 + occ2, {'0': noeud1, '1': noeud2}))
        # ajoute au tas le noeud de poids occ1+occ2 et avec les fils noeud1 et noeud2

    return heappop(tas)[1]


def code_huffman_parcours(prefixe, noeud, code):
    if '0' in noeud:
        code_huffman_parcours(prefixe + "0", noeud['0'], code)
        code_huffman_parcours(prefixe + "1", noeud['1'], code)
    else:

        code[noeud['opcode']] = prefixe


def code_huffman(arbre):
    # retourne le codage associe a l'arbre deja construit.
    code = {}
    code_huffman_parcours('', arbre, code)
    return code


if __name__ == "__main__":

    import sys

    data = ""
    for l in sys.stdin:
        data += l

    parts = re.split("===============================", data)

    FilenameRegExp = re.compile("filename: (.*)")
    ExchangedbitsRegExp = re.compile("Exchangedbits: (\d+)")
    BitsFromPCRegExp = re.compile("BitsFromPC: (\d+)")
    BitsFromRamRegExp = re.compile("BitsFromRam: (\d+)")
    BitsToRamRegExp = re.compile("BitsToRam: (\d+)")

    print(parts[0])

    Filename = re.search(FilenameRegExp, parts[0])
    BitsFromPCReg = re.search(ExchangedbitsRegExp, parts[1])
    BitsFromPC = re.search(BitsFromPCRegExp, parts[1])
    BitsFromRam = re.search(BitsFromRamRegExp, parts[1])
    BitsToRam = re.search(BitsToRamRegExp, parts[1])

    occurences = {}

    for l in parts[2].splitlines():
        tokens = re.findall('[\S]+', l)
        if tokens != [] and tokens != None:
            occurences[str(tokens[0])] = int(tokens[1])

    print(occurences)
    encodage = code_huffman(arbre_huffman(occurences))

    dump1 = "| Opcode | Mnemonic |\n"
    dump1 += "| ------ | -------  |\n"

    for k in encodage.keys():
        dump1 += "| " + str(k) + "|" + str(encodage[k]) + "| \n"

    occurences = {}
    for l in parts[3].splitlines():
        tokens = re.findall('[\S]+', l)
        if tokens != [] and tokens != None:
            occurences[tokens[0]] = int(tokens[1])

    encodage = code_huffman(arbre_huffman(occurences))

    dump2 = "| Opcode | Mnemonic |\n"
    dump2 += "| ------ | -------  |\n"

    for k in encodage.keys():
        dump2 += "| " + str(k) + "|" + str(encodage[k]) + "| \n"

    occurences = {}
    for l in parts[3].splitlines():
        tokens = re.findall('[\S]+', l)
        if tokens != [] and tokens != None:
            occurences[str(tokens[0])] = int(tokens[1])

    encodage = code_huffman(arbre_huffman(occurences))

    dump3 = "| Opcode | Mnemonic |\n"
    dump3 += "| ------ | -------  |\n"

    for k in encodage.keys():
        dump3 += "| " + str(k) + "|" + str(encodage[k]) + "| \n"

    dump = parts[1] + "\n" + dump1 + "\n" + dump2 + "\n" + "dump3"

    f = open(Filename.group(1) + ".report", "w")
    f.write(dump)
    f.close()

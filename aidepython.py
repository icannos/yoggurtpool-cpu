# coding: UTF-8

# Ce fichier contient une implémentation complète du codage et du décodage de
# Huffman pour des chaînes de caractères. Les algorithmes sont efficaces,
# l'implémentation sacrifie par endroits un peu de vitesse au profit de la
# simplicité.

###  Algorithme de Huffman pour la création du code

# Cette partie représente la construction du code de Huffman à partir d'un
# texte. La partie suivante s'occupe du codage et du décodage.
#
# On utilise la représentation suivante des arbres binaires:
# - chaque nœud est un dictionnaire
# - les nœuds internes ont des champs 'gauche' et 'droite', les feuilles n'en
#   ont pas.
# - les valeurs des feuilles sont rangées dans les champs 'val'


# Construction d'une table de fréquences
#
# Entrée: un texte
# Sortie: un dictionnaire qui associe chaque symbole présent à sa fréquence

def table_frequences (texte):
    table = {}
    for caractere in texte:
        if caractere in table:
            table[caractere] = table[caractere] + 1
        else:
            table[caractere] = 1
    return table


# Construction d'un arbre de Huffman
#
# Entrée: un dictionnaire qui associe chaque symbole à sa fréquence
# Sortie: un arbre binaire portant les symboles aux feuilles

from heapq import *

def huffman_arbre (frequences):
    tas = []

    # Construction d'un tas avec les lettres sous forme de feuilles

    tas = [(freq, {'val': lettre}) for (lettre, freq) in frequences.items()]
    heapify(tas)

    # Aggrégation des arbres

    while len(tas) >= 2:
        freq1, gauche = heappop(tas)
        freq2, droite = heappop(tas)
        heappush(tas, (freq1 + freq2, {'0': gauche, '1': droite}))

    # Renvoi de l'arbre

    _, arbre = heappop(tas)
    return arbre

essai = {'add' : 12 , 'sub' :98, 'let':31,'push':3,'pop':3}
print(huffman_arbre(essai))
# Transformation d'un arbre binaire en code.
#
# Entrée: un arbre binaire portant des symboles aux feuilles
# Sortie: un dictionnaire qui associe à chaque valeur de feuille le code
#   correspondant, comme liste d'entiers (0 ou 1)
#
# La méthode employée est récursive, on utilise une fonction auxiliaire qui
# établit le code de chaque valeur d'un sous-arbre en connaissant le préfixe
# commun des codes de ce sous-arbre.

def table_codage (arbre):
    code = {}

    def code_sous_arbre (prefixe, noeud):
        if '0' in noeud:
            # cas d'un nœud interne
            code_sous_arbre(prefixe + "0", noeud['0'])
            code_sous_arbre(prefixe + "1", noeud['1'])
        else:
            # cas d'une feuille
            code[noeud['val']] = prefixe

    code_sous_arbre("", arbre)
    return code

print(table_codage(huffman_arbre(essai)))

###  Codage et décodage par des suites de bits

# La méthode naturelle en Python serait d'écrire une classe capable de faire
# des entrées et sorties bit par bit sur un flux (fichier ou autre). Pour
# simplifier, on procède sans objets, en maintenant l'état du codage dans un
# dictionnaire.

## Fonctions auxiliaires: codage des entiers en base 2

def code_base2 (nombre, taille):
    bits = []
    for i in range(taille):
        bits.insert(0, nombre % 2)
        nombre = nombre / 2
    return bits

def decode_base2 (bits):
    nombre = 0
    for bit in bits:
        nombre = 2 * nombre + bit
    return nombre


## Écriture de suites de bits dans un chaîne de caractère

# L'état est un dictionnaire comportant les champs suivants:
# - sortie : la sortie prouite jusque là (suite d'octets sous forme de chaîne
#   de caractères)
# - tampon : une suite de bits, de longueur au plus 7, qui contient les
#   premiers bits à écrire dans le prochain octet

# Création de l'état initial

def init_sortie ():
    return {'sortie': '', 'tampon': []}

# Écriture d'un bit

def ecrire_bit (etat, bit):
    bits = etat['tampon'] + [bit]
    if len(bits) == 8:
        etat['sortie'] = etat['sortie'] + chr(decode_base2(bits))
        etat['tampon'] = []
    else:
        etat['tampon'] = bits

# Écriture d'une suite de bits

def ecrire_bits (etat, bits):
    for bit in bits:
        ecrire_bit(etat, bit)

# Écriture des derniers bits restant dans le tampon et extraction du résultat

def sortie_finale (etat):
    if len(etat['tampon']) > 0:
        ecrire_bits(etat, [0]*(8 - len(etat['tampon'])))
    return etat['sortie']


## Lecture de suites de bits dans un chaîne de caractères

# Ici, l'état est un dictionnaire comportant les champs suivants:
# - entree : le texte à décomposer
# - position : la position du prochain caractère à lire
# - tampon : un suite de bits à lire avant le prochain caractère (de longueur
#   au plus 7)
# Il n'y a pas de test pour détecter si la fin de la chaîne est atteinte,
# parce qu'on ne s'en sert pas ici.

# Initialisation

def init_entree (entree):
    return {'entree': entree, 'position': 0, 'tampon': []}

# Lecture d'un bit

def lire_bit (etat):
    suite = etat['tampon']

    # Lire le prochain caractère si besoin

    if suite == []:
        caractere = etat['entree'][etat['position']]
        etat['position'] = etat['position'] + 1
        suite = code_base2(ord(caractere), 8)

    # Extraire le premier bit

    etat['tampon'] = suite[1:]
    return suite[0]

# Lecture d'une suite de bits

def lire_bits (etat, taille):
    bits = []
    for i in range(taille):
        bits.append(lire_bit(etat))
    return bits


## Codage des arbres binaires

# Ceci est un exemple de codage d'un arbre binaire contenant des caractères
# (de 8 bits) aux feuilles. Le codage d'une feuille est un bit 0 suivi du code
# du caractère, le codage d'un arbre non réduit à une feuille est un bit 1
# suivi des codages des sous-arbres gauche et droit.

def ecrire_arbre (etat, arbre):
    if 'gauche' in arbre:
        ecrire_bit(etat, 1)
        ecrire_arbre(etat, arbre['gauche'])
        ecrire_arbre(etat, arbre['droite'])
    else:
        ecrire_bit(etat, 0)
        ecrire_bits(etat, code_base2(ord(arbre['val']), 8))

def lire_arbre (etat):
    bit = lire_bit(etat)
    if bit == 1:
        gauche = lire_arbre(etat)
        droite = lire_arbre(etat)
        return {'gauche': gauche, 'droite': droite}
    else:
        code = decode_base2(lire_bits(etat, 8))
        return {'val': chr(code)}


### Codage de Huffman complet

# Le code utilisé ici est:
# - la taille du texte (codée sur 32 bits)
# - l'arbre de codage
# - le code effectif du texte
#
# Si le texte est vide, on ne met ni arbre ni code. Si le texte utilise un
# seul symbole, on met l'arbre (réduit à une feuille) mais pas le code (qui
# est vide de toute façon).

def code_huffman (texte):
    etat = init_sortie()
    ecrire_bits(etat, code_base2(len(texte), 32))

    if len(texte) != 0:
        table = table_frequences(texte)
        arbre = huffman_arbre(table)
        ecrire_arbre(etat, arbre)

        if 'val' not in arbre:
            code = table_codage(arbre)
            for caractere in texte:
                ecrire_bits(etat, code[caractere])

    return sortie_finale(etat)

def decode_huffman (chaine):
    entree = init_entree(chaine)
    taille = decode_base2(lire_bits(entree, 32))

    if taille == 0:
        return ''

    arbre = lire_arbre(entree)
    if 'val' in arbre:
        return arbre['val'] * taille

    texte = ''
    etat = arbre
    while taille > 0:
        if lire_bit(entree) == 0:
            etat = etat['gauche']
        else:
            etat = etat['droite']
        if 'val' in etat:
            texte = texte + etat['val']
            taille = taille - 1
            etat = arbre

    return texte


# Petit test: évolution de la taille du code en fonction de la taille de
# l'entrée, et comparaison avec la compression zlib de la bibliothèque de
# Python (combinaison de LZ77 et codage de Huffman).
#
# Utilisation de la fonction:
#   croissance(texte, "sortie.csv", pas)
# où le texte est une chaîne de caractères, dont on compressera des parties de
# tailles de plus en plus grandes. Le fichier "sortie.csv" contiendra des
# lignes de la forme
#   L,H,Z1,Z9
# où les quatre champs sont des nombres entiers:
#   L = longueur du texte brut utilisé
#   H = longueur après compression par Huffman telle que définie ici
#   Z1 = longueur après compression par zlib, qualité 1
#   Z9 = longueur après compression par zlib, qualité 9
# Le paramètre de qualité influe essentiellement sur la taille de la fenêtre
# utilisée pour chercher des répétitions dans l'algorithme de Lempel-Ziv.

import zlib

def croissance (texte, fichier, pas):
    out = open(fichier, "w")
    for i in range(0, len(texte), pas):

        # Affichage d'un indicateur de progression
        if i%100 == 0:
            print i

        test = texte[:i]
        out.write("%d,%d,%d,%d\n" % (i,
            len(code_huffman(test)),
            len(zlib.compress(test, 1)),
            len(zlib.compress(test, 9))
            ))
    out.close()

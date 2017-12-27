##### Recommandations

###### Constantes:
Nous n'avons pas de constantes de taille 16 or nous stockons les couleurs sur 16 bits ainsi nous gagnerions énormément de bits (un facteur 2 en réalité) à chaque fois que l'on écrit un pixel. Par ailleurs dans notre implémentation du son, nous utilisons aussi 16 bits pour stocker une note et une durée.

###### Push / pop(readse)
D'après les statistiques que nous avons pu retirer de nos différents essais il apparaît que que ce sont 2 instructions très utilisées et en nombre équivalent. Il serait pas mal de donner un opcode plus court à push.

###### Instructions à 3 opérandes
Ces instructions sont vraiment peu souvents utilisées et on pourrait leur attribuer des opcodes plus longs sans problème.

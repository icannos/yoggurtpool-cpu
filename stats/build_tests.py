

eff_file = open("t_multeff.s", "r")
paseff_file = open("t_mult.s")


eff = eff_file.read()
paseff = paseff_file.read()


eff_file.close()
paseff_file.close()


for i in range(10, 10**9, 100000):
    newfileeff = eff.replace("VARA", str(i))
    newfileeff = newfileeff.replace("VARB", str(i))
    newfile = paseff.replace("VARA", str(i))
    newfile = newfile.replace("VARB", str(i))

    eff_file = open("t_multeff-" + str(i) + ".ss", "w")
    paseff_file = open("t_mult-" + str(i) + ".ss", "w")

    eff_file.write(newfileeff)
    paseff_file.write(newfile)

    eff_file.close()
    paseff_file.close()




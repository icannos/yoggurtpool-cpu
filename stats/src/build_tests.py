

eff_file = open("t_multeff.s", "r")
paseff_file = open("t_mult.s")


eff = eff_file.read()
paseff = paseff_file.read()


eff_file.close()
paseff_file.close()


for i in range(10, 10**8, 10**7):
    newfileeff = eff.replace("VAR1", str(i))
    newfileeff = newfileeff.replace("VAR2", str(i))
    newfile = paseff.replace("VAR1", str(i))
    newfile = newfile.replace("VAR2", str(i))

    eff_file = open("t_multeff-" + str(i) + ".ss", "w")
    paseff_file = open("t_mult-" + str(i) + ".ss", "w")

    eff_file.write(newfileeff)
    paseff_file.write(newfile)

    eff_file.close()
    paseff_file.close()




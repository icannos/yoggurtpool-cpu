

import re
from matplotlib import pyplot


effdata = []
normaldata = []
X=[]

for i in range(10, 10**8, 10**7):
    f = open("t_mult-"+str(i) + ".ss.obj.report")
    data = f.read()
    f.close()

    ch = re.search("BitsFromPC: (\d+)", data)

    normaldata.append(int(ch[1]))

    f = open("t_multeff-" + str(i) + ".ss.obj.report")
    data = f.read()
    f.close()

    ch = re.search("BitsFromPC: (\d+)", data)
    effdata.append(int(ch[1]))

    X.append(i)




pyplot.plot(X, effdata, label = "Efficace")
pyplot.plot(X, normaldata, label="Pas efficace" )


pyplot.show()




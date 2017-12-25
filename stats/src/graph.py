

import re
from matplotlib import pyplot


effdata = []
normaldata = []
X=[]

for i in range(10, 10**6, 10**5):
    f = open("t_mult-"+str(i) + ".ss.obj.report")
    data = f.read()
    f.close()

    ch = re.search("BitsFromPC: (\d+)", data)

    normaldata.append(ch[1])

    f = open("t_multeff-" + str(i) + ".ss.obj.report")
    data = f.read()
    f.close()

    ch = re.search("BitsFromPC: (\d+)", data)
    effdata.append(ch[1])

    X.append(i)


print(effdata)
print(normaldata)


pyplot.plot(X, effdata)
pyplot.plot(X, normaldata)

pyplot.show()




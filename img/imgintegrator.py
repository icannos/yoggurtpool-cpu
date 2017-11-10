

from PIL import Image
import numpy as np







def buildAsm(path, name):
    im = Image.open(path)
    asm = ""
    asm  += "print_img_" + name + ":\n"
    asm += "leti r4 1073350139 \n"

    asm += "setctr a0 r4 \n"
    asm += "leti r4 0 \n"

    for pixel in iter(im.getdata()):
        r,g,b = pixel
        bb = np.binary_repr(b, 5)
        bg = np.binary_repr(g, 5)
        br = np.binary_repr(r, 6)
        bgr = bg + bb + br
        bgr = int(bgr, 2)

        asm += "leti r4 " + str(bgr) + "\n"
        asm += "write a0 16 r4 \n"

    f = open(name + ".s", "w")
    f.write(asm)
    f.close()



buildAsm("test2.jpg", "test2")
















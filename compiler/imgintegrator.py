

from PIL import Image
import numpy as np


def buildFullImgScreen(path, name):
    im = Image.open(path)
    asm = ""
    asm  += "print_img_" + name + ":\n"
    asm += "leti r4 1073350080 \n"

    asm += "setctr a0 r4 \n"
    asm += "leti r4 0 \n"

    for pixel in iter(im.getdata()):
        r,g,b = pixel
        bb = np.binary_repr(int(31*b/255), 5)
        bg = np.binary_repr(int(31*g/255), 5)
        br = np.binary_repr(int(63*r/255), 6)

        print(len(bg))

        bgr = br + bg + bb
        sbgr = int(bgr, 2)

        asm += "leti r4 " + str(sbgr) + "\n"
        asm += "write a0 16 r4 \n"

    f = open(name + ".s", "w")
    f.write(asm)
    f.close()


def buildPosImgMask(path, name):
    """
    Assumes that bottom left corner is stored in (r1,r2) & color stored in r0
    :param path:
    :param name:
    :return:
    """

    # Load img
    im = Image.open(path)
    width, height = im.size

    asm = ""


    asm += "leti "



    asm  += "print_img_" + name + ":\n"

    asm += "leti r4 1073350080 \n"

    asm += "setctr a0 r4 \n"
    asm += "leti r4 0 \n"

    for pixel in iter(im.getdata()):
        r,g,b = pixel
        bb = np.binary_repr(int(31*b/255), 5)
        bg = np.binary_repr(int(31*g/255), 5)
        br = np.binary_repr(int(63*r/255), 6)

        print(len(bg))

        bgr = br + bg + bb
        sbgr = int(bgr, 2)

        asm += "leti r4 " + str(sbgr) + "\n"
        asm += "write a0 16 r4 \n"

    f = open(name + ".s", "w")
    f.write(asm)
    f.close()















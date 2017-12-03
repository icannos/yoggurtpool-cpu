#! /usr/bin/python3


from PIL import Image, ImageOps
import argparse

import os

def getAllChar(ascii_path):
    img = Image.open(ascii_path)

    chars = []
    for i in range(128):
        char = img.crop((i*8, 0, (i+1)*8, 8))
        char = ImageOps.mirror(char)
        chars.append(char)

    font_encoded = ""
    for im in chars:
        for pixel in iter(im.getdata()):
            if pixel == 0:
                font_encoded += "1"
            else:
                font_encoded += "0"

    return font_encoded

def dumpbmpfont(encoded_font, path):
    f = open(path, "w")
    f.write(encoded_font)
    f.close()


if __name__ == '__main__':

    argparser = argparse.ArgumentParser(description='This encode an img bmp font to its inline binary cod; built for the ASR2017 processor @ ENS-Lyon')

    argparser.add_argument('filename',
                           help='name of the source file.')

    argparser.add_argument('--output',
                           help='output path')



    options = argparser.parse_args()
    encoded_str = getAllChar(options.filename)

    basefilename, extension = os.path.splitext(options.filename)

    if options.output == None:
        dumppath = basefilename + ".mem"
    else:
        dumppath = options.output

    dumpbmpfont(encoded_str, dumppath)


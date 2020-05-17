#!/usr/bin/env python3
import sys
import os
import os.path
import imageio
from pygifsicle import optimize

def main(gif_file, filenames):
    print("gif_file =", gif_file)  # DEBUG
    print("filenames =", filenames)  # DEBUG
    with imageio.get_writer(gif_file, mode='I', duration=1.0) as writer:
        for filename in filenames:
            if not os.path.exists(filename):
                continue
            print("  adding image", filename)
            image = imageio.imread(filename)
            writer.append_data(image)
    print("GIF was written to", gif_file)
    optimize(gif_file)
    print("GIF was optimize using pygifsicle on file", gif_file)


if __name__ == "__main__":
    gif_file = sys.argv[1]
    filenames = sys.argv[2:]
    sys.exit(main(gif_file, filenames))

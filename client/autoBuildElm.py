#!/usr/bin/env python3

import os
import subprocess

def run_commands():
    os.chdir('gameClient')
    os.system('python ./tools/build.py')
    subprocess.Popen("python ./tools/watchNbuild.py src ./tools/build.py", shell=True)

if __name__ == "__main__":
    run_commands()

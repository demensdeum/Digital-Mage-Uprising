#!/usr/bin/env python3

import os
import subprocess
import shlex

def run_commands():
    os.chdir('gameClient')
    os.system('python ./tools/build.py')
    subprocess.Popen("python ./tools/server.py", shell=True)
    subprocess.Popen("python ./tools/watchNbuild.py src ./tools/build.py", shell=True)
    os.chdir('typeScript-src')
    subprocess.Popen("python ../tools/watchNbuild.py src ./tools/build.py", shell=True)
    while True:
        pass

if __name__ == "__main__":
    run_commands()

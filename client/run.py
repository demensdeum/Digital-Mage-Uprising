#!/usr/bin/env python3

import os

def run_commands():
    # Change directory to 'gameClient'
    os.chdir('gameClient')

    # Change directory to 'typeScript-src'
    os.chdir('typeScript-src')

    # Execute the build.bat script inside typeScript-src/tools
    os.system('python ./tools/build.py')

    # Go back one directory to 'gameClient'
    os.chdir('..')

    # Execute the build.bat script inside gameClient/tools
    os.system('python ./tools/build.py')

    # Execute the run.bat script inside gameClient/tools
    os.system('python ./tools/run.py')

if __name__ == "__main__":
    run_commands()

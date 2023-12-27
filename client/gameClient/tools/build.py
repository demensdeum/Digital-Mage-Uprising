#!/usr/bin/env python3

import os
import shutil

def run_commands():
    # Change directory to 'src'
    os.chdir('src')

    # Compile Main.elm to Elm-main.js
    os.system('elm make Main.elm --output=../build/Elm-main.js')

    # Go back one directory to the parent directory
    os.chdir('..')

    # Copy the 'external-libs' directory to 'build' directory recursively
    shutil.copytree('external-libs', 'build', dirs_exist_ok=True)

if __name__ == "__main__":
    run_commands()

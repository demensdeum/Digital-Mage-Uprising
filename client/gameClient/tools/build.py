#!/usr/bin/env python3

import os
import shutil
import cleanterminus

def run_commands():
    cleanterminus.clear()
    os.chdir('src')
    os.system('elm make Main.elm --output=../build/Elm-main.js')
    os.chdir('..')
    shutil.copytree('external-libs', 'build', dirs_exist_ok=True)

if __name__ == "__main__":
    run_commands()

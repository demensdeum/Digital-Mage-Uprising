#!/usr/bin/env python3

import os
import shutil

def run_commands():
    os.chdir('src')
    os.system('elm make Main.elm --output=../build/Elm-main.js')
    os.chdir('..')
    shutil.copytree('external-libs', 'build', dirs_exist_ok=True)

if __name__ == "__main__":
    run_commands()

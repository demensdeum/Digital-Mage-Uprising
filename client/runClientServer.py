#!/usr/bin/env python3

import os
import subprocess
import cleanterminus

def run_commands():
    os.chdir('gameClient')
    os.system("python ./tools/server.py")

if __name__ == "__main__":
    cleanterminus.clear()
    run_commands()

#!/usr/bin/env python3

import os

def run_commands():
    # Change directory to 'gameServer'
    os.chdir('gameServer')

    # Compile using rebar3
    os.system('rebar3 compile')

    # Start the shell using rebar3
    os.system('rebar3 shell')

if __name__ == "__main__":
    run_commands()

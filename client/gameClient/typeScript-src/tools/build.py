#!/usr/bin/env python3

import os
import subprocess
import cleanterminus

def run_commands():
    # Clear the console
    cleanterminus.clear()

    # Install TypeScript using npm
    os.system('npm install typescript')

    # Add the local node_modules/.bin directory to the PATH
    os.environ["PATH"] += os.pathsep + os.path.join('.', 'node_modules', '.bin')

    # Execute the preprocessor.py script with the specified arguments
    preprocessor_path = os.path.join('.', 'tools', 'preprocessor', 'preprocessor.py')
    src_path = os.path.join('.', 'src')
    src_preprocessed_path = os.path.join('.', 'src-preprocessed')
    rules_path = os.path.join('.', 'tools', 'preprocessor', 'rules.json')

    try:
        subprocess.run(['python', preprocessor_path, src_path, src_preprocessed_path, rules_path], check=True)
    except subprocess.CalledProcessError as e:
        print(f"An error occurred! Exit code: {e.returncode}")
        exit(e.returncode)

    # Compile TypeScript using tsc
    os.system('tsc')

if __name__ == "__main__":
    run_commands()

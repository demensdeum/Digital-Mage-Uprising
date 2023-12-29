#!/usr/bin/env python3

import sys
import time
from watchdog.observers import Observer
from watchdog.events import FileSystemEventHandler
import subprocess

need_reload = False

class FilesChangeHandler(FileSystemEventHandler):
    def on_modified(self, event):
        if event.is_directory:
            return
        elif event.event_type == 'modified':
            print(f'File {event.src_path} has been modified. Running bat file...')
            rebuild()

def rebuild():
    try:
        subprocess.run([build_script])
    except Exception as e:
        print(f'Error running build script file: {e}')

if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("Usage: python script.py <directory_path> <bat_file_path>")
        sys.exit(1)

    directory_path = sys.argv[1]
    build_script = sys.argv[2]
    
    event_handler = FilesChangeHandler()
    rebuild()
    observer = Observer()
    observer.schedule(event_handler, directory_path, recursive=False)

    print(f'Watching directory: {directory_path}')
    print(f'Build script: {build_script}')
    
    observer.start()

    while True:
        pass
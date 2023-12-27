#!/usr/bin/env python3

import time

import os

for i in range(10):
    if os.system('python ./tools/server.py') == 0:
        break
    time.sleep(1)
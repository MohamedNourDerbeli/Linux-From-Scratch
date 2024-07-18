#!/usr/bin/python

import os
import platform
import subprocess
import psutil
import sys
import time
import re

def info_disk():
    """
    a function that return a list of disks and their size each
    return: list of tuples
    """
    try:
        output = subprocess.check_output("lsblk -nd -o NAME,SIZE,TYPE", shell=True)
        lines = output.decode().strip().split('\n')
        disk_info = []
        for line in lines:
            if "disk" in line:
                parts = line.split()
                name = parts[0]
                size = parts[1]
                disk_info.append((name, size))
        return disk_info
    except subprocess.CalledProcessError:
        return []

def delete_file(file_path):
    try:
        os.remove(file_path)
        print(f"File {file_path} deleted successfully.")
    except FileNotFoundError:
        print(f"File {file_path} not found.")
    except PermissionError:
        print(f"Permission denied: unable to delete {file_path}.")
    except Exception as e:
        print(f"Error deleting file {file_path}: {e}")
        
def flush_then_wait():
    sys.stdout.flush()
    sys.stderr.flush()
    time.sleep(0.5)
    

def simple_percent_parser(output):
    progress_re = re.compile("Total complete: (\d+)%")
    m = progress_re.search(output)
    if m:
        pc_complete = m.group(1)
        return int(pc_complete)

#!/usr/bin/env python3
import shutil
import psutil
from network import *


def check_disk_usage(disk, threshold):
    """Verifies that there's enough free space on disk"""
    du = shutil.disk_usage(disk)
    free = du.free / du.total * 100
    return free > threshold


def check_cpu_usage():
    """Verifies that there's enough unused CPU"""
    usage = psutil.cpu_percent(1)
    return usage < 75


# If there's not enough disk, or not enough CPU, print an error
if not check_disk_usage('/', 5) or not check_cpu_usage():
    print("Either disk is full or CPU is overloaded!")
elif check_localhost() and check_connectivity():
    print("Everything ok")
else:
    print("Network checks failed")

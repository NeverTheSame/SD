#!/usr/bin/env python3

import requests
import socket


def check_localhost():
    localhost = socket.gethostbyname('localhost')
    return localhost == "127.0.0.1"


def check_connectivity():
    # request = requests.get("http://www.google.com")
    request = requests.get("https://ops-log.oneiq.com")
    # request = requests.get("https://www.oneiq.com/")
    return request.status_code == 200


print(check_connectivity())
#!/usr/bin/env python3


"""
platform_debug_info.py
"""


import platform
import requests
import fiona
import SPARQLWrapper

print()
print('system       :', platform.system())
print('release      :', platform.release())
print('version      :', platform.version())
print('machine      :', platform.machine())
print('processor    :', platform.processor())
print("Python       :", platform.python_version())
print("Fiona        :", fiona.__version__)
print("SPARQLWrapper:", SPARQLWrapper.__version__)
print("requests     :", requests.__version__)
print()

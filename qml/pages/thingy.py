#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import pyotherside
from random import random

def rand(stuff):
    pyotherside.send('text', stuff)
    pyotherside.send('random', random())

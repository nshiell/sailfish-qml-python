#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import pyotherside
import random

def bbb():
    pyotherside.send('finished', random.random())

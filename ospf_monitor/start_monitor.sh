#!/bin/bash

ps ax | grep main.py | grep -v grep | awk '{print $1; system("sudo kill -9 " $1)}'
sudo python main.py

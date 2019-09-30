#!/bin/bash
#
# This file called by gnome session startup to start conky system monitoring for user session
#
sleep 10 && conky --config=/home/blake/.conky/conkyrc_1920x1080;

#!/usr/bin/env python3

# modified version of getMonitorInfo.py
# (last line changed "current" monitor info
# change to enable start_conky_laptop.sh capabilities

import tkinter as tk

root = tk.Tk()

cols = root.winfo_screenwidth()
rows = root.winfo_screenheight()


# the screen contains all monitors
print("screen size: %d x %d" % (rows, cols))


# current monitor
print("%d x %d (current)" % (cols, rows))

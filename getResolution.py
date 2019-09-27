#!/usr/bin/env python

# modified version of getMonitorInfo.py 
# (last line changed "current" monitor info
# change to enable start_conky_laptop.sh capabilities

import gtk


window = gtk.Window()

# the screen contains all monitors
screen = window.get_screen()
print "screen size: %d x %d" % (gtk.gdk.screen_width(),gtk.gdk.screen_height())

# collect data about each monitor
monitors = []
nmons = screen.get_n_monitors()
print "there are %d monitors" % nmons
for m in range(nmons):
  mg = screen.get_monitor_geometry(m)
  print "monitor %d: %d x %d" % (m,mg.width,mg.height)
  monitors.append(mg)

# current monitor
curmon = screen.get_monitor_at_window(screen.get_active_window())
x, y, width, height = monitors[curmon]
#print "monitor %d: %d x %d (current)" % (curmon,width,height) 
print "%d x %d (current)" % (width,height) 

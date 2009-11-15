#!/usr/bin/env python

"""
Author: Marilen Corciovei
Version: $Id: som3d.py,v 1.6 2007/01/12 23:04:56 len Exp $
Description: 3D SOM example
License: BSD

"""

import gtk
import som, random

class SOMDisplay(som.SOM):
    def __init__(self):
        som.SOM.__init__(self, 32, 3, som.SOM_algorithm(32))
        #som.SOM.__init__(self, 32, 3, som.SA_two_phases(32))
        self.initialize_nodes()
        self.initialize_samples()
        self.W = int(400/32)*32
        self.H = self.W
        self.TIMEOUT = 20
        window = gtk.Window(gtk.WINDOW_TOPLEVEL)
        window.set_title("SOM 3d representation")
        window.connect("destroy", lambda w: gtk.main_quit())
        self.area = gtk.DrawingArea()
        self.area.set_size_request(self.W, self.H)
        window.add(self.area)
        self.area.connect("expose-event", self.draw_network)
        self.area.show()
        window.show()

    def initialize_samples(self):
        self.test_data = []
        self.test_data.append([1,0,0])
        self.test_data.append([0,1,0])
        self.test_data.append([0,0,1])
        self.test_data.append([0,1,1])
        self.test_data.append([1,1,0])
        self.test_data.append([1,0,1])
        self.vsize = len(self.test_data)

    def next_sample(self):
        #ri = random.randint(0, len(self.test_data)-1)
        #return self.test_data[ri]
        return [ random.random() for i in range(3) ]

    def timed_training(self):
        gtk.timeout_add(self.TIMEOUT, self.timer)

    def timer(self):
        if self.train_step() == 0:
            gtk.timeout_add(self.TIMEOUT, self.timer)
            self.refresh()

    def draw_network(self, area, event):
        self.style = self.area.get_style()
        self.gc = self.style.fg_gc[gtk.STATE_NORMAL]
        #self.setColor(.9,0,0)
        #self.area.window.draw_rectangle(self.gc, True, 10, 10, 20, 20)
        wi = self.W/self.r
        hi = self.H/self.r

        for x in range(self.r):
            for y in range(self.r):
                self.setColor(self.nodes[x*self.r+y][0], self.nodes[x*self.r+y][1], self.nodes[x*self.r+y][2])
                self.area.window.draw_rectangle(self.gc, True, x*wi, y*hi, wi, hi)

    def setColor(self,red,green,blue,mult=65535):
        color = self.gc.get_colormap().alloc_color(int(red * mult), int(green * mult), int(blue * mult))
        self.gc.set_foreground(color)

    def refresh(self):
        self.area.emit("expose-event", gtk.gdk.Event(gtk.gdk.EXPOSE))
        self.area.queue_draw()

def main():
    net = SOMDisplay()
    net.timed_training()
    gtk.main()
    return 0

if __name__=='__main__':
    main()

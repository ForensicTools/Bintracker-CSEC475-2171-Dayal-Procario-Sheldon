#!/usr/bin/python

from cmd import Cmd
import os

class Bintracker(Cmd):

    def do_quit(self,args):
        """ Quits the program"""
        print "bye"
        raise SystemExit

    def do_read(self,args):
        """ Reads in a pcap file """
        if len(args)==0:
            print "USAGE: read <pcap file>"
        else:
            pcap = args
            command = 'bro -r '+pcap+' extract_all.bro'
            os.system(command)

if __name__ == '__main__':
    prompt = Bintracker()
    prompt.prompt= '>> '
    prompt.cmdloop('Starting Bintracker....')



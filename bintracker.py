#!/usr/bin/python

from cmd import Cmd
import os

ascii="""\

 /$$$$$$$        /$$$$$$       /$$   /$$       /$$$$$$$$       /$$$$$$$         /$$$$$$         /$$$$$$        /$$   /$$       /$$$$$$$$       /$$$$$$$
| $$__  $$      |_  $$_/      | $$$ | $$      |__  $$__/      | $$__  $$       /$$__  $$       /$$__  $$      | $$  /$$/      | $$_____/      | $$__  $$
| $$  \ $$        | $$        | $$$$| $$         | $$         | $$  \ $$      | $$  \ $$      | $$  \__/      | $$ /$$/       | $$            | $$  \ $$
| $$$$$$$         | $$        | $$ $$ $$         | $$         | $$$$$$$/      | $$$$$$$$      | $$            | $$$$$/        | $$$$$         | $$$$$$$/
| $$__  $$        | $$        | $$  $$$$         | $$         | $$__  $$      | $$__  $$      | $$            | $$  $$        | $$__/         | $$__  $$
| $$  \ $$        | $$        | $$\  $$$         | $$         | $$  \ $$      | $$  | $$      | $$    $$      | $$\  $$       | $$            | $$  \ $$
| $$$$$$$/       /$$$$$$      | $$ \  $$         | $$         | $$  | $$      | $$  | $$      |  $$$$$$/      | $$ \  $$      | $$$$$$$$      | $$  | $$
|_______/       |______/      |__/  \__/         |__/         |__/  |__/      |__/  |__/       \______/       |__/  \__/      |________/      |__/  |__/




"""

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
    prompt.intro = 'Bintracker - Malicious file analyser'
    prompt.cmdloop(ascii)



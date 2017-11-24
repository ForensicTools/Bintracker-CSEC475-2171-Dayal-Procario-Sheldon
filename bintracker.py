#!/usr/bin/python

from cmd import Cmd
import os

ascii="""\

    ____  _____   ____________  ___   ________ __ __________
   / __ )/  _/ | / /_  __/ __ \/   | / ____/ //_// ____/ __ \
  / __  |/ //  |/ / / / / /_/ / /| |/ /   / ,<  / __/ / /_/ /
 / /_/ _/ // /|  / / / / _, _/ ___ / /___/ /| |/ /___/ _, _/
/_____/___/_/ |_/ /_/ /_/ |_/_/  |_\____/_/ |_/_____/_/ |_|

"""

class Bintracker(Cmd):


    def do_quit(self,args):
        """ Quits the program"""
        print "bye"
        raise SystemExit

    def do_extract(self,args):
        """ extracts files from pcap file """
        if len(args)==0:
            print "USAGE: read <pcap file>"
        else:
            pcap = args
            print "\nExtracting files from %s\n" % pcap
            command = 'bro -r '+pcap+' extract_all.bro'
            os.system(command)

    def do_verify(self,args):
        """ Verifies file hashes against virustotal"""
        if len(args)==0:
            print "USAGE: verify <api_key>"
        else:
            api_key = args
            os.system("python md5-ify.py %s" %  api_key)
            os.system("python scan_check.py %s" % api_key)
            os.system("python print_results.py")

if __name__ == '__main__':
    prompt = Bintracker()
    prompt.prompt= '>> '
    prompt.intro ="""Bintracker - File and malware  analyser\n

        COMMANDS:
            1) extract <pcap file> : extracts files from pcap file
            2) verify <api_key> : verify file hashes using virustotal api
            3) help
            4) quit
    """
    prompt.cmdloop(ascii+prompt.intro)



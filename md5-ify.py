import os
import csv
from os import listdir
from os.path import isfile, join
import hashlib
import requests
import json
import sys

md5hash_list = []
directory = "./extract_files/"

if os.path.exists("./extract_files"):
	# for each file in the directory
	for f in listdir(directory):
		#if exists ./extract_files/<filename>
		if isfile(join(directory, f)):
			#concatenate the directory + filename
			file_name = join(directory, f)
			
			#get the hash of the file content, not filename
			#file content doesn't change, names can.
			hashed_file = hashlib.md5(open(file_name,'rb').read()).hexdigest()
			
			md5hash_list.append(hashed_file)

else:
	print "Error loading extract_files directory. Verify bro script creates it, and is properly named"
	sys.exit(1)


#create a virustotal API request
params = {'apikey': '<your api key>', 'resource': '/home/pastrami/Desktop/bro_project/hashes.csv'}
headers = {
	"Accept-Encoding": "gzip, deflate",
	"User-Agent" : "gzip,  My Python requests library example client or username"
}
response = requests.post('https://www.virustotal.com/vtapi/v2/file/rescan',params=params)
json_response = response.json()

with open('response.txt', 'w') as outfile:
    json.dump(json_response, outfile)

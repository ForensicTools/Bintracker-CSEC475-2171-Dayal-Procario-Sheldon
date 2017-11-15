from os import listdir
from os.path import isfile, join
import hashlib
import requests
import json
import sys

md5hash_table = {}
directory = "./extract_files/"

# for each file in the directory
for f in listdir(directory):
	#if exists ./extract_files/<filename>
	if isfile(join(directory, f)):
		#concatenate the directory + filename
		file_name = join(directory, f)
		
		#get the hash of the file content, not filename
		#file content doesn't change, names can.
		hashed_file = hashlib.md5(open(file_name,'rb').read()).hexdigest()
		
		md5hash_table[f] = hashed_file

print(md5hash_table)

"""
#create a virustotal API request
params = {'apikey': '<YOUR-API-KEY>', 'resource': hashed_file}
headers = {
	"Accept-Encoding": "gzip, deflate",
	"User-Agent" : "gzip,  My Python requests library example client or username"
}
response = requests.post('https://www.virustotal.com/vtapi/v2/file/rescan',params=params)
json_response = response.json()
"""
		

import requests
import json
import datetime
import os
import sys

#Set user's API key
api_key = sys.argv[1]

#Set parameters to query the VirusTotal API
params = {'apikey': api_key, 'resource': 'ff0b1f7acd32ecbbee828eb30cdee352c1a3884e707c083a5fcdcf3147964a94-1510768272'}


headers = {
"Accept-Encoding": "gzip, deflate",
"User-Agent" : "gzip,  My Python requests library example client or username"
}

#Get the response from VirusTotal
response = requests.get('https://www.virustotal.com/vtapi/v2/file/report',params=params, headers=headers)
json_response = response.json()

#Create a unique file with the date at runtime
time = datetime.datetime.now()
file_dir = './results/'
filename = file_dir + str(time.year) + '-' +  str(time.month) + '-' + str(time.day) + '-result.txt'

#Create directory if it doesn't exists
if not os.path.exists(file_dir):
    os.makedirs(file_dir)

#Open the file created, put json results inside
with open(filename, 'w') as result:
	json.dump(json_response, result)


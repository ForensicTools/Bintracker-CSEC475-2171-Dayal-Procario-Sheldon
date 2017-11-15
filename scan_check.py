import requests
import json
import datetime

params = {'apikey': '<YOUR-API-KEY>', 'resource': 'ff0b1f7acd32ecbbee828eb30cdee352c1a3884e707c083a5fcdcf3147964a94-1510768272'}
headers = {
"Accept-Encoding": "gzip, deflate",
"User-Agent" : "gzip,  My Python requests library example client or username"
}
response = requests.get('https://www.virustotal.com/vtapi/v2/file/report',params=params, headers=headers)
json_response = response.json()

time = datetime.datetime.now()
filename = './results/' + str(time.year) + '-' +  str(time.month) + '-' + str(time.day) + '-result.txt'

with open(filename, 'w') as result:
	json.dump(json_response, result)


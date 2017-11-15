import requests

	params = {'apikey': '<YOUR-API-KEY>', 'resource': resource}
	headers = {
	  "Accept-Encoding": "gzip, deflate",
	  "User-Agent" : "gzip,  My Python requests library example client or username"
	  }
	response = requests.post('https://www.virustotal.com/vtapi/v2/file/rescan',params=params)
	json_response = response.json()

######
# scan_check.py
# 
# this script relies on the bintracker.py shell
# queries the VirusTotal API to get the results back from
# the submitted files. The script will count how many malicious
# entries were detected by the API, if any, and return the amount
# by pushing it to a new column in the CSV that is dynamically constructed.
# if no results are found, it defaults to 0.
######

import requests
import json
import datetime
import os
import sys
import csv

#Set user's API key
api_key = sys.argv[1]
#create a linked list with new result virus count for CSV
all = []

print "Gathering Results\n"

#opens the CSV for interpretation
with open('bintracker_results.csv', 'r') as csvFile:
	
	csvReader = csv.reader(csvFile)

	for row in csvReader:
		# grab the scan_id from the CSV
		scan_id = row[2]
		result_count = 0

		if scan_id != "NULL":
			#Set parameters to query the VirusTotal API
			params = {'apikey': api_key, 'resource': scan_id}


			headers = {
			"Accept-Encoding": "gzip, deflate",
			"User-Agent" : "gzip,  My Python requests library example client or username"
			}

			#Get the response from VirusTotal
			response = requests.get('https://www.virustotal.com/vtapi/v2/file/report',params=params, headers=headers)
			
			if response.status_code == 200:
				result = response.json()
				if 'positives' in result:
					
					#counter for virus reslts	
					if result['positives'] > 0:
			
						#count the number of scans
						for key,value in result['scans'].items():
							scanner_results = value
							scanner_detected = scanner_results['detected']
							result = result + scanner_detected
				
							row.append(result_count)
							all.append(row)
					else:
						row.append(result_count)
						all.append(row)
				else:
					row.append(result_count)
					all.append(row)
			else:
				row.append(result_count)
				all.append(row)

		# if nothing found, default to 0 count
		else:
			row.append(result_count)
			all.append(row)

# write the newly added count coulmn to the bintracker_results CSV
with open('bintracker_results.csv', 'w') as csvOutput:
	csvWriter = csv.writer(csvOutput, lineterminator='\n')
	csvWriter.writerows(all)

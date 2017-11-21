import json
import datetime

time = datetime.datetime.now()
file_dir = './results/'
filename = file_dir + str(time.year) + '-' +  str(time.month) + '-' + str(time.day) + '-result.txt'

with open(filename) as json_data:
	result = json.load(json_data)

if result['positives'] ==  0:
	for key,value in result['scans'].items():
		scanner_name = key
		scanner_results = value
		scanner_detected = scanner_results['detected']
		print("%s detected %d malicious results" % (scanner_name, scanner_detected))
#	for key in scans.items():
		
#if result['positives'] == 0:
#	print "No Malicious files found"

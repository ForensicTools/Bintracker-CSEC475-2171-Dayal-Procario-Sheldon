import json

with open('./results/2017-11-15-result.json') as json_data:
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

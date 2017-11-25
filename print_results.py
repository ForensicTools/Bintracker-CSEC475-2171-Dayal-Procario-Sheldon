######
# print_results.py
# relies on the bintracker.py shell simulator
# prints out the filename and the count of how many
# malicious detections were recorded from scan_check.py
###### 

import csv

# open the CSV to interpret
with open('bintracker_results.csv', 'r') as inFile:

	csvReader = csv.reader(inFile)
	for row in csvReader:

		#get the filename
		filename = row[0]
		#get the number of malware detected
		results = row[3]
		
		print 'Filename: {:28s} | Malware: {:6s}'.format(filename,results)

print "\nFor a more in-depth report, check the \"bintracker_results.csv\" file\n"

import csv


with open('bintracker_results.csv', 'r') as inFile:

	csvReader = csv.reader(inFile)
	for row in csvReader:
		filename = row[0]
		results = row[3]
		
#		print("Filename: %s | Malicious results: %s" % (filename,results))
		print 'Filename: {:28s} | Malware: {:6s}'.format(filename,results)

print "\nFor a more in-depth report, check the \"bintracker_results.csv\" file\n"

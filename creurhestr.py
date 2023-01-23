import sys
import requests
import json

if len(sys.argv) != 2:
    print("Defnydd:\n\t", sys.argv[0], "[cais.xml]")
    sys.exit()

overpass_url = "http://overpass-api.de/api/interpreter"

try:
    ff = open(sys.argv[1], "r")
except:
    print("Gwall wrth agor ffeil ", sys.argv[1], ":\t", sys.exc_info()[0])
    raise
    sys.exit()

overpass_query = ff.read()

response = requests.get(overpass_url, 
                        params={'data': overpass_query})

response.encoding = 'utf-8'
allbwn = response.text
print(allbwn.encode('utf-8'))

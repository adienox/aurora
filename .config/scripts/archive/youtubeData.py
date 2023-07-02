#! /bin/python3

from datetime import datetime
import requests
import dateparser
import sys
import json

with open('/home/nex/Documents/api.key', 'r') as file:
    apiKey = file.read()
    

# Yoinked the following function from https://stackoverflow.com/a/50992575
def makeOrdinal(n):
    '''
    Convert an integer into its ordinal representation:
        makeOrdinal(0)   = '0th'
        makeOrdinal(3)   = '3rd'
        makeOrdinal(122) = '122nd'
        makeOrdinal(213) = '213th'
    '''
    n = int(n)
    if 11 <= (n % 100) <= 13:
        suffix = 'th'
    else:
        suffix = ['th', 'st', 'nd', 'rd', 'th'][min(n % 10, 4)]
    return str(n) + suffix

def getData(id):
    '''
    Get metadata from youtube using the Youtube Data Api v3.
    Requires youtube link as a parameter and returns json data.
    Returnes (title, channelName, publishDate, tags, description) as a tuple.
    '''

    response = requests.get(f'https://youtube.googleapis.com/youtube/v3/videos?part=snippet&id={id}&key={apiKey}')
    response = json.loads(response.text)

    title = response['items'][0]['snippet']['title']
    channelName = response['items'][0]['snippet']['channelTitle']
    description = response['items'][0]['snippet']['description']
    
    try:
        tags = response['items'][0]['snippet']['tags']
        listTag = ''
        for tag in tags:
            listTag += '[[' + tag + ']] '
    except:
        listTag = ''

    date = dateparser.parse(response['items'][0]['snippet']['publishedAt'])
    ordinalDay = makeOrdinal(date.strftime("%d"))
    publishDate = date.strftime(f"%b {ordinalDay}, %Y")

    return title, channelName, publishDate, listTag, description

url = sys.argv[1]
id = url[32:]
metadata = getData(id)

ordinalCurrentDay = makeOrdinal(datetime.now().strftime("%d"))
ndate = datetime.now().strftime(f"%b {ordinalCurrentDay}, %Y")

print(f'''
### Youtube
tags:: [[youtube]] {metadata[3]}
status:: [[🔸Doing / Synthesising]]
presenter:: [[{metadata[1]}]]
link:: {url}
title:: [[{metadata[0]}]]
published-on:: [[{metadata[2]}]]
processed-on:: [[{ndate}]]
    - [[Youtube Embed]]
        - <iframe width="1280" height="720" src="https://www.youtube.com/embed/{id}" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
    - [[Description]]
        - #+BEGIN_VERSE\n{metadata[4]}\n#+END_VERSE
    - [[Notes]]
        - <!--Write notes here-->
''')

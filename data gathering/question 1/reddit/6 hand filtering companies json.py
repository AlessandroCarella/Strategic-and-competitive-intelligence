import json
import os
from os import path

folderPath = path.join(os.getcwd(), "data gathering", "question 1", "reddit")

with open (path.join(folderPath, "companies dictionary.json"), "r") as f:
    filtered_dict = dict(json.load(f))

handFilteredDict = {}
for company, frequency in filtered_dict.items():
    while True:
        answer = input("is " + str(company) + " a company?\t") 
        if answer == "y" or answer == "yes":
            handFilteredDict[company] = frequency
            break
        elif answer == "n" or answer == "no":
            handFilteredDict[company] = int(frequency/300)
            break
        elif "e" in answer: 
            #some company names such as "nothing" are actually a well knowed company 
            #but also an english word, i decided to cut the frequency of them by less than usual
            handFilteredDict[company] = int(frequency/50)
            break
            
    with open (path.join(folderPath, "companies dictionary hand filtered.json"), "w") as f:
        json.dump(handFilteredDict, f, indent=4)


import json

with open (r"C:\Users\alex1\Desktop\Strategic-and-competitive-intelligence\data gathering\question 1\twitter\companies dictionary hand filtered.json") as f:
    data = dict(json.load(f))

sorted_dict = dict(sorted(data.items(), key=lambda item: item[1], reverse=True))

import csv
with open (r"C:\Users\alex1\Desktop\Strategic-and-competitive-intelligence\data gathering\question 1\twitter\question1TwitterData.csv", "w", newline='') as f:
    # Create a CSV writer object
    writer = csv.writer(f)
    
    # Write the header row
    writer.writerow(['company', 'count'])
    
    # Write each key-value pair as a row
    for company, count in sorted_dict.items():
        writer.writerow([company, count])
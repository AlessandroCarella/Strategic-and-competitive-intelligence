import json
import os
from os import path

folderPath = path.join(os.getcwd(), "data gathering")

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

"""
i decided to stop at 200 companies since we don't really need that many companies informations for this question

is Google a company?    y
is OpenAI a company?    y
is Microsoft a company? y
is next a company?      n
is Twitter a company?   r
is Twitter a company?   y
is test a company?      n
is Notion a company?    y
is GitHub a company?    y
is Some a company?      n
is nothing a company?   e
is Amazon a company?    ^Y
is Amazon a company?    y
is Apple a company?     y
is Open a company?      e
is LinkedIn a company?  y
is Blockchain a company?        e
is yes a company?       n
is Tesla a company?     y
is Spotify a company?   y
is Grammarly a company? y
is Canva a company?     y
is whatever a company?  n
is Meta a company?      y
is Netflix a company?   y
is Binance a company?   e
is Human a company?     e
is Insider a company?   y
is Reddit a company?    y
is Android a company?   n
is Adobe a company?     y
is Quizlet a company?   y
is Other a company?     n
is Chegg a company?     y
is Picsart a company?   y
is Current a company?   e
is John a company?      e
is Sundar a company?    n
is Global a company?    e
is Telegram a company?  y
is Slack a company?     y
is Nothing a company?   e
is Test a company?      e
is Salesforce a company?        y
is Impact a company?    w
is Impact a company?    e
is Discord a company?   y
is Indian a company?    n
is DeepMind a company?  y
is Opera a company?     y
is Developer a company? e
is Startup a company?   n
is Testing a company?   e
is Coinbase a company?  y
is MAN a company?       y
is Via a company?       e
is Duolingo a company?  y
is Advanced a company?  e
is Yahoo a company?     y
is IBM a company?       y
is James a company?     e
is Shopify a company?   y
is San a company?       n
is freelance a company? n
is Udemy a company?     y
is Student a company?   n
is ReactJS a company?   n
is Quality a company?   e
is SpaceX a company?    y
is Upwork a company?    e
is MIT a company?       y
is 2018 a company?      n
is Figma a company?     y
is Unity a company?     y
is Indeed a company?    y
is Progress a company?  e
is DuckDuckGo a company?        y
is CNET a company?      y
is OpenSea a company?   y
is Together a company?  e
is NVIDIA a company?    y
is Wish a company?      y
is Killer a company?    e
is Block a company?     e
is Freelancer a company?        n
is Milestone a company? y
is Upgrade a company?   e
is Uber a company?      y
is Believe a company?   e
is Walmart a company?   y
is Stripe a company?    y
is K12 a company?       y
is Private a company?   n
is Twitch a company?    y
is Instacart a company? y
is anonymous a company? n
is Grab a company?      y
is Neuralink a company? y
is Audience a company?  e
is Etsy a company?      y
is ABC a company?       y
is Lab a company?       e
is Mars a company?      e
is Random a company?    e
is YES a company?       e
is smile a company?     e
is Django a company?    n
is Harness a company?   e
is Lambda a company?    n
is Oracle a company?    y
is 700 a company?       n
is FTX a company?       y
is DeepL a company?     y
is Self a company?      e
is SAP a company?       y
is FAST a company?      e
is Lensa a company?     e
is CMC a company?       y
is Target a company?    y
is Gemini a company?    e
is AMD a company?       y
is Airtable a company?  y
is Analysts a company?  e
is Airbnb a company?    y
is TCS a company?       y
is Fresh a company?     e
is XYZ a company?       y
is Descript a company?  e
is Rest a company?      n
is Evolution a company? n
is Pinecone a company?  y 
is PayPal a company?    y
is Empower a company?   y
is Assembly a company?  n
is Shell a company?     y
is Ripple a company?    y
is Sedo a company?      y
is Moving a company?    n
is Roblox a company?    y
is ASI a company?       e
is Bird a company?      e
is SAS a company?       e
is Databricks a company?        y
is Genesis a company?   e
is Joseph a company?    e
is Chase a company?     e
is HELLO a company?     e
is Confidential a company?      e
is slice a company?     e
is Vector a company?    e
is Ghost a company?     n
is Realtime a company?  y
is MongoDB a company?   n
is Klarna a company?    y
is SenseTime a company? y
is Infosys a company?   y
is Accenture a company? y
is Nuance a company?    e
is Sage a company?      e
is Anonymous a company? n
is Clubhouse a company? y
is Gong a company?      e
is Deezer a company?    y
is Curated a company?   e
is Ada a company?       n
is Sony a company?      y
is RAM a company?       n
is Champions a company? n
is eBay a company?      y
is Gartner a company?   y
is IDK a company?       n
is Dropbox a company?   y
is Sequoia a company?   e
is Base a company?      n
is Twilio a company?    y
is Nasdaq a company?    y
is Blind a company?     e
is Freelance a company? n
is GoDaddy a company?   y
is Royal a company?     n
is ByteDance a company? y
is Default a company?   n
is Cohere a company?    y
is TradingView a company?       y
is Informatica a company?       e
is Nokia a company?     y
is Citi a company?      e
is Prove a company?     e
is Pattern a company?   e
is Orange a company?    e
is Peak a company?      e
is Genesys a company?   e
is OKX a company?       y
is fabric a company?    n
is Ivy a company?       n
is EOS a company?       e
is UBS a company?       y
is Aptos a company?     y
is Wix a company?       y
is Foundry a company?   y
is noon a company?      e
is Mozilla a company?   y
is Gem a company?       y
is Patreon a company?   y
is Comcast a company?   y
is Wise a company?      y
is Tata a company?      y
is Zoho a company?      y
is KPMG a company?      y
is Swipe a company?     e
is Deloitte a company?  y
is Citizen a company?   
"""
from scholarly import scholarly

# Define your search query
query = '(((("ai-driven" OR "ai" OR "ai driven") AND "competitive intelligence") OR (("ai-driven" OR "ai" OR "ai driven") AND "competitive analysis")) AND ("ethical implications" OR "ethical considerations" OR "ethical")) AND ("social media" OR "website")'

# Search for papers
search_query = scholarly.search_pubs_query(query)

# Fetch and print the results
for i, result in enumerate(search_query):
    print(f"Result {i+1}:")
    print("Title:", result.bib['title'])
    print("Authors:", result.bib['author'])
    print("Year:", result.bib['year'])
    print("URL:", result.bib['url'])
    print()

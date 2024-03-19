# Install and load the required packages
#install.packages("rvest")
#install.packages("jsonlite")
library(rvest)
library(jsonlite)

# Specify the URL of the website you want to scrape
generalQueryBaseFormat <- "https://stackoverflow.com/search?q="
query <- "generative+ai"
url <- paste0(generalQueryBaseFormat, query)

# Read the HTML content of the webpage
page <- read_html(url)

# Extract all the links from the webpage
links <- page %>% 
  html_nodes("a") %>% 
  html_attr("href")

# Filter links to include only those that end with '?r=SearchResults'
filtered_links <- links[grep("\\?r=SearchResults$", links)]

# Extract the string values from the filtered links
filtered_links_strings <- gsub('.*/(.*?)"', '\\1', filtered_links)

# Convert the filtered links to JSON format
filtered_links_json <- toJSON(filtered_links_strings, pretty = 4)

# Check if filtered_links_json is empty
if (length(filtered_links_json) == 0) {
  cat("Open Stack Overflow on a browser and complete the captcha. Then rerun the program.\n")
  q("no")
}

# Write the JSON data to a file
writeLines(filtered_links_json, "links.json")

#the saved file is a json list of strings formatted as such
#"/questions/78007243/utilizing-gemini-through-vertex-ai-or-through-google-generative-ai?r=SearchResults",
#"/questions/77825027/improve-document-ai-generative-ai-accuracy?r=SearchResults",
#we can just append them to the string "https://stackoverflow.com/"
#and we have the qeustion page   
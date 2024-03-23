# Install and load the required packages
#install.packages("rvest")
#install.packages("jsonlite")
library(rvest)
library(jsonlite)

source("utility.r")

update_page_number <- function(url, new_page) {
  # Define the regular expression pattern to match the page parameter
  pattern <- "(page=\\d+)"
  
  # Replace the page parameter value with the new page number
  updated_url <- gsub(pattern, paste0("page=", new_page), url)
  
  return(updated_url)
}

getAllQuestionsLinks <- function(numberOfResultsWanted, url, pageNumber = 1, allLinks = character(), numberOfResults = 1){
    while (numberOfResults <= numberOfResultsWanted) {
        # Extract all the links from the webpage # nolint
        links = read_html(url) %>% 
          html_nodes("a") %>% 
          html_attr("href")

        # Filter links to include only those that contain '?r=SearchResults'
        filtered_links = links[grepl("\\?r=SearchResults", links)]

        if (length(filtered_links) == 0){
            print ("general page")
            solve_captcha ()
            return (getAllQuestionsLinks(numberOfResultsWanted, url, pageNumber, allLinks, numberOfResults))
        }

        # Extract the string values from the filtered links
        filtered_links_strings = gsub('.*/(.*?)"', '\\1', filtered_links)

        allLinks = c(allLinks, filtered_links_strings)
        numberOfResults = length(allLinks)
        
        if ((length(filtered_links_strings) != 49) && (length (allLinks) != numberOfResultsWanted)){
            print (sprintf("Could not find %d results, found only %d", numberOfResultsWanted, length(allLinks)))
            return (allLinks)
        }

        pageNumber = pageNumber + 1
        url = update_page_number (url, pageNumber)
    }

    #reduce the lenght of the 
    if (numberOfResults > numberOfResultsWanted){
        allLinks <- allLinks[1:(numberOfResultsWanted)]
    }

    return(allLinks)
}

getQuestionsLinks <- function(numberOfResultsWanted, query) {
    # Specify the URL of the website you want to scrape
    #https://stackoverflow.com/search?page=1&tab=Relevance&pagesize=50&q=generative%20ai
    generalQueryBaseFormat = "https://stackoverflow.com/search?page=1&tab=Relevance&pagesize=50&q="
    url = paste0(generalQueryBaseFormat, query)
    print ("your full url is")
    print (url)

    #get all the questions by the method
    filtered_links_strings = getAllQuestionsLinks(numberOfResultsWanted, url)

    # Convert the filtered links to JSON format
    filtered_links_json = toJSON(filtered_links_strings, pretty = 4)

    # Write the JSON data to a file
    writeLines(filtered_links_json, "questions links.json")

    return (filtered_links_strings)

    #the saved file is a json list of strings formatted as such
    #"/questions/78007243/utilizing-gemini-through-vertex-ai-or-through-google-generative-ai?r=SearchResults",
    #"/questions/77825027/improve-document-ai-generative-ai-accuracy?r=SearchResults",
    #we can just append them to the string "https://stackoverflow.com/"
    #and we have the question page   
}
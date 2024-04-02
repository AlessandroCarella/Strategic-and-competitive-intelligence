library(yaml)
library(jsonlite)
library(openxlsx)
library(writexl)
library(tibble)

source("queryOptions.r")
source("getAllQuestionsLinks.r")
source("extractDataFromQuestionPage.r")

#generative ai [python] code:print -[macos] -[opencv]
query = formulate_query (
    #put your general query here, remember to use \" for words
    #or sentences that needs to match in the query result
    "generative ai", 
    c(
        "", #tags (strings separated by spaces)
        "", #ignore tags (strings separated by spaces)
        "", #user (integer as a string or "me" for the user (have to be logged in stackoverflow))
        "", #min score (integer string)
        "", #min answer (integer string)
        "", #min view (integer string)
        "", #code (string with code)
        "", #closed ("yes" or "no")
        "", #duplicated ("yes" or "no")
        "", #is question ("yes" or "no")
        ""
        
        #for all of the following there is an example usage, 
        #you can always leave everything empty ("")
        #example
        # "python opencv windows", #tags (strings separated by spaces)
        # "macos linux", #ignore tags (strings separated by spaces)
        # "1234 || me", #user (integer as a string or "me" for the user (have to be logged in stackoverflow))
        # "1000", #min score (integer string)
        # "10", #min answer (integer string)
        # "2000", #min view (integer string)
        # "print (\"hello\")", #code (string with code)
        # "yes || no", #closed ("yes" or "no")
        # "yes || no", #duplicated ("yes" or "no")
        # "yes || no", #is question ("yes" or "no")
        # "yes || no" #is answer ("yes" or "no")
    )
)
print ("Your query is")
print (query)

questionsLinks = getQuestionsLinks (3, query)
questions_list <- list()
for (questionLink in questionsLinks) {
    questionObj <- extractDataFromQuestionPage(questionLink)
    questions_list <- c(questions_list, questionObj)
}

#----------------------------------------------------------------
#EXCEL
print ("ciao")

#----------------------------------------------------------------
#YAML

print ("Creatin YAML")
toYamlQuestionList <- list()
for (questionObj in questions_list) {
    toYamlQuestionList <- c(toYamlQuestionList, questionObj$to_list())
}

# Write the list of objects to YAML
write_yaml(toYamlQuestionList, "questions.yaml")

print ("Finished execution, you will find the data in the questions.yaml file")
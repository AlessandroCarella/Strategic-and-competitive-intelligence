library(yaml)
library(jsonlite)

source("queryOptions.r")
source("getAllQuestionsLinks.r")
source("extractDataFromQuestionPage.r")

#generative ai [python] code:print -[macos] -[opencv]
query = formulate_query ()
print ("Your query is")
print (query)

questionsLinks = getQuestionsLinks (20, query)
questions_list <- list()
for (questionLink in questionsLinks) {
    questionObj <- extractDataFromQuestionPage(questionLink)
    questions_list <- c(questions_list, questionObj$to_list())
}

# Write the list of objects to YAML
write_yaml(questions_list, "questions.yaml")

print ("Finished execution, you will find the data in the questions.yaml file")
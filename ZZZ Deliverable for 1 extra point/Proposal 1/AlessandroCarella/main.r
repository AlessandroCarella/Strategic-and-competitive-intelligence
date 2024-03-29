library(yaml)
library(jsonlite)
library(openxlsx)
library(writexl)
library(tibble)

source("queryOptions.r")
source("getAllQuestionsLinks.r")
source("extractDataFromQuestionPage.r")

#generative ai [python] code:print -[macos] -[opencv]
query = "generative+ai"#formulate_query ()
print ("Your query is")
print (query)

questionsLinks = getQuestionsLinks (3, query)
questions_list <- list()
for (questionLink in questionsLinks) {
    questionObj <- extractDataFromQuestionPage(questionLink)
    questions_list <- c(questions_list, questionObj$to_dataframe())
}

#----------------------------------------------------------------
#EXCEL
print ("Creating excel")

# Convert questions to lists


# Write the list of lists to an Excel file
write_xlsx(as_tibble(questions_list), "questions.xlsx")

#----------------------------------------------------------------
#YAML

print ("Creatin YAML")
# Write the list of objects to YAML
write_yaml(questions_list, "questions.yaml")

print ("Finished execution, you will find the data in the questions.yaml file")
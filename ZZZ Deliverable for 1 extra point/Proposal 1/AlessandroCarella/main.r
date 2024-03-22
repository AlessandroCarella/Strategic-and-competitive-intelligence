library(yaml)

source("getAllQuestionsLinks.r")
source("extractDataFromQuestionPage.r")

query = "list in python"

questionsLinks = getQuestionsLinks (3, query)
questions_list <- list()
for (questionLink in questionsLinks) {
    questionObj <- extractDataFromQuestionPage(questionLink)
    questions_list <- c(questions_list, questionObj$to_list())
}

# Write the list of objects to YAML
write_yaml(questions_list, "objects.yaml")
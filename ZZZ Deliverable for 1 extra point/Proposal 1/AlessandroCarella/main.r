source("getAllQuestionsLinks.r")
source("extractDataFromQuestionPage.r")
library(jsonlite)

query = "generative ai"

questionsLinks = getQuestionsLinks (10, query)
questions <- list()
for (questionLink in questionsLinks) {
    questions <- c(questions, extractDataFromQuestionPage(questionLink))
}

df <- data.frame(
    questionTitle = sapply(questions, function(x) slot(x, "questionTitle")),
    questionVotes = sapply(questions, function(x) slot(x, "questionVotes")),
    questionText = sapply(questions, function(x) slot(x, "questionText")),
    questionCode = sapply(questions, function(x) slot(x, "questionCode")),
    answerNumber = sapply(questions, function(x) slot(x, "answerNumber")),
    stringsAsFactors = FALSE
)

# Write the df to json
writeLines(df, "questions_output.json", pretty = TRUE, digits = 4)

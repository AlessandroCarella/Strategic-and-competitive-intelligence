if (!require("stringr")) {
  install.packages("stringr")
}

library(rvest)
library(stringr)

source("utility.r")

setClass("Question",
         slots = list(
            questionTitle = "character",
            questionVotes = "numeric",
            questionText = "character",
            questionCode = "list",
            answerNumber = "numeric"
        )
    )

new_Question <- function(question_title, question_votes, question_text, question_code, answer_number){
    return (new("Question",
        questionTitle = question_title,
        questionVotes = question_votes,
        questionText = question_text,
        questionCode = question_code,
        answerNumber = answer_number
    ))
}

valid_web_page <- function (webpage){
    out = webpage %>%
            html_node(xpath = "//h1[@class='fs-headline1 ow-break-word mb8 flex--item fl1']/a") %>%
            html_text()

    #if the webpage has not been loaded correctly the result of the above operation is NULL
    return (!is.null(out)) 
}

checkCompatibility <- function(questionTitle, questionVotes, questionText, questionCode, answerNumber) {
  # Create an empty list to store compatibility results
  compatibility_list <- list()

  # Check if each input value is compatible with the class definition
  compatibility_list$questionTitle <- is.character(questionTitle)
  compatibility_list$questionVotes <- is.numeric(questionVotes)
  compatibility_list$questionText <- is.character(questionText)
  compatibility_list$questionCode <- is.list(questionCode)
  compatibility_list$answerNumber <- is.numeric(answerNumber)

  return(compatibility_list)
}

extractDataFromQuestionPage <- function(questionLink){
    questionLink = paste0("https://stackoverflow.com/", questionLink)
    
    webpage <- read_html(questionLink) 

    if (!valid_web_page(webpage)) {
        solve_captcha()
        return(extractDataFromQuestionPage(questionLink))
    }

    question_title = webpage %>%
            html_node(xpath = "//h1[@class='fs-headline1 ow-break-word mb8 flex--item fl1']/a") %>%
            html_text()

    question_votes = as.numeric(
        webpage %>%
        html_node(".js-vote-count") %>%
        html_text() %>%
        trimws()
    )

    question_text = webpage %>%
        html_nodes(".question.js-question") %>%
        html_nodes(".s-prose.js-post-body") %>%
        html_nodes("p") %>%
        html_text() %>%
        paste(collapse = "\n")
    
    question_code = webpage %>%
        html_nodes(".question.js-question") %>%
        html_nodes(".s-prose.js-post-body") %>%
        html_nodes("pre") %>%
        html_nodes("code") %>%
        html_text()

    answers_number = as.numeric(
        webpage %>%
        html_node("h2[data-answercount]") %>%
        html_attr("data-answercount")
    )

    # Check compatibility with Question class
    compatibilities = checkCompatibility(question_title, question_votes, question_text, question_code, answers_number)
    if (!compatibilities[[1]]) {
    question_title <- ""
    }
    if (!compatibilities[[2]]) {
    question_votes <- 0
    }
    if (!compatibilities[[3]]) {
    question_text <- ""
    }
    if (!compatibilities[[4]]) {
    question_code <- list()
    }
    if (!compatibilities[[5]]) {
    answers_number <- 0
    }
    

    return (
        new_Question (
            question_title,
            question_votes,
            question_text,
            question_code,
            answers_number
        )
    )
}




#questionPage <- "questions/522563/how-to-access-the-index-value-in-a-for-loop"
#extractDataFromQuestionPage(questionPage)

#save full page to html file
#writeLines(as.character(read_html(paste0("https://stackoverflow.com/", questionPage))), "output.html")
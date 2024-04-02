library(rvest)
library(stringr)
library(tibble)

source("utility.r")
source("classes.r")

# Function to extract comments
extract_comments <- function(comment_elements) {
  comments <- list()
  for (element in comment_elements) {
    comment_text <- html_text(html_nodes(element, ".comment-copy"))
    comment_user <- html_text(html_nodes(element, ".comment-user"))
    comment <- Comment$new(comment_text, comment_user)
    comments <- c(comments, list(comment))
  }
  return(comments)
}

# Function to extract answers
extract_answers <- function(answer_elements) {
    answers <- list()
    for (element in answer_elements) {
        answer_id <- html_attr(element, "data-answerid")
        answer_text <- html_text(html_nodes(element, ".js-post-body"))
        answer_code <- html_text(html_nodes(element, "pre code"))
        answer_votes <- as.integer(html_attr(html_nodes(element, ".js-vote-count"), "data-value"))
        answer_num_comments <- as.integer(html_text(html_nodes(element, ".js-post-comments-component .comment-count")))
        comment_elements <- html_nodes(element, ".js-post-comments-component .js-comment")
        answer_comments <- extract_comments(comment_elements)
        answer <- Answer$new(answer_id, answer_text, answer_code, answer_votes, answer_num_comments, answer_comments)
        answers <- c(answers, list(answer))
    }
    return(answers)
}

valid_web_page <- function (webpage){
    out = webpage %>%
            html_node(xpath = "//h1[@class='fs-headline1 ow-break-word mb8 flex--item fl1']/a") %>%
            html_text()

    #if the webpage has not been loaded correctly the result of the above operation is NULL
    return (!is.null(out)) 
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

    # Create a list to store answer objects
    answers_list <- extract_answers(html_nodes(webpage, ".js-answer"))   

    # Create a Question object and initialize it with extracted data
    question <- Question$new(question_title, question_votes, question_text, question_code, answers_number, answers_list)

    return (question)
}

# questionPage <- "questions/522563/how-to-access-the-index-value-in-a-for-loop"
# extractDataFromQuestionPage(questionPage)

#save full page to html file
#writeLines(as.character(read_html(paste0("https://stackoverflow.com/", questionPage))), "output.html")


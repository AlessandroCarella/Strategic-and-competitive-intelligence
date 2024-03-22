library(rvest)
library(stringr)

source("utility.r")

Question <- R6::R6Class(
    "Question",
    public = list(
        question_title = NULL,
        question_votes = NULL,
        question_text = NULL,
        question_code = NULL,
        answers_number = NULL,
        answers = NULL,  # List of Answer objects
        initialize = function (question_title, question_votes, question_text, question_code, answers_number, answers) {
            self$question_title <- question_title
            self$question_votes <- question_votes
            self$question_text <- question_text
            self$question_code <- question_code
            self$answers_number <- answers_number  # Corrected variable name
            self$answers <- answers
        },
        to_list = function() {
            list(
                question_title = self$question_title,
                question_votes = self$question_votes,
                question_text = self$question_text,
                question_code = self$question_code,
                answers_number = self$answers_number,
                answers = lapply(self$answers, function(answer) answer$to_list())
            )
        }
    )
)

Answer <- R6::R6Class(
    "Answer",
    public = list(
        answer_id = NULL,
        answer_text = NULL,
        answer_code = NULL,
        answer_votes = NULL,
        answer_num_comments = NULL,
        answer_comments = NULL,
        initialize = function(answer_id, answer_text, answer_code, answer_votes, answer_num_comments, answer_comments) {
            self$answer_id <- answer_id
            self$answer_text <- answer_text
            self$answer_code <- answer_code
            self$answer_votes <- answer_votes
            self$answer_num_comments <- answer_num_comments
            self$answer_comments <- answer_comments
        },
        to_list = function() {
            list(
                answer_id = self$answer_id,
                answer_text = self$answer_text,
                answer_code = self$answer_code,
                answer_votes = self$answer_votes,
                answer_num_comments = self$answer_num_comments,
                answer_comments = lapply(self$answer_comments, function(comment) comment$to_list())
            )
        }
    )
)

Comment <- R6::R6Class(
    "Comment",
    public = list(
        comment_text = NULL,
        comment_user = NULL,
        initialize = function(comment_text, comment_user) {
            self$comment_text <- comment_text
            self$comment_user <- comment_user
        },
        to_list = function() {
            list(
                comment_text = self$comment_text,
                comment_user = self$comment_user
            )
        }
    )
)



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


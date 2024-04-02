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

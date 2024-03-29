library(tibble)  # For creating dataframes

# Define the classes Question, Answer, and Comment
Question <- R6::R6Class(
  "Question",
  public = list(
    question_title = NULL,
    question_votes = NULL,
    question_text = NULL,
    question_code = NULL,
    answers_number = NULL,
    answers = NULL,
    initialize = function(question_title, question_votes, question_text, question_code, answers_number, answers) {
      self$question_title <- question_title
      self$question_votes <- question_votes
      self$question_text <- question_text
      self$question_code <- question_code
      self$answers_number <- answers_number
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

# Sample data
question1 <- Question$new(
  question_title = "Title 1",
  question_votes = 10,
  question_text = "Question text 1",
  question_code = "Code 1",
  answers_number = 2,
  answers = list(
    Answer$new(
      answer_id = 1,
      answer_text = "Answer text 1",
      answer_code = "Answer code 1",
      answer_votes = 5,
      answer_num_comments = 1,
      answer_comments = list(
        Comment$new(
          comment_text = "Comment 1",
          comment_user = "User 1"
        )
      )
    ),
    Answer$new(
      answer_id = 2,
      answer_text = "Answer text 2",
      answer_code = "Answer code 2",
      answer_votes = 3,
      answer_num_comments = 0,
      answer_comments = list()
    )
  )
)

question2 <- Question$new(
  question_title = "Title 2",
  question_votes = 20,
  question_text = "Question text 2",
  question_code = "Code 2",
  answers_number = 1,
  answers = list(
    Answer$new(
      answer_id = 3,
      answer_text = "Answer text 3",
      answer_code = "Answer code 3",
      answer_votes = 8,
      answer_num_comments = 2,
      answer_comments = list(
        Comment$new(
          comment_text = "Comment 2",
          comment_user = "User 2"
        ),
        Comment$new(
          comment_text = "Comment 3",
          comment_user = "User 3"
        )
      )
    )
  )
)

# Convert questions to lists
questions_list <- lapply(list(question1, question2), function(q) q$to_list())

# Convert list to dataframe
questions_df <- as_tibble(questions_list)

# Print dataframe
print(questions_df)

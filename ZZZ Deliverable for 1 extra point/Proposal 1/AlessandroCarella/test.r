# Define the Question class
setClass("Question",
         slots = list(
           questionTitle = "character",
           questionVotes = "numeric",
           questionText = "character",
           questionCode = "list",
           answerNumber = "numeric"
         )
)

# Define a method for the Question class to check compatibility
setMethod("isCompatible",
          signature = "Question",
          function(object) {
            # Check if object is compatible with the Question class
            is_compatible <- all(c(
              inherits(object, "Question"),
              length(slotNames("Question")) == length(slot(object)),
              all(sapply(slotClasses("Question"), function(x) x %in% c("character", "numeric", "list"))),
              all(sapply(slot(object), function(x) class(x) %in% slotClasses("Question")))
            ))
            return(is_compatible)
          }
)

# Create a function to check compatibility of input values with the Question class
checkCompatibility <- function(title, votes, text, code, answerNumber) {
  # Create a new Question object
  new_question <- new("Question",
                      questionTitle = title,
                      questionVotes = votes,
                      questionText = text,
                      questionCode = code,
                      answerNumber = answerNumber)
  
  # Check compatibility using the isCompatible method
  compatible <- isCompatible(new_question)
  
  # Return list of boolean indicating compatibility
  return(list(compatible = compatible))
}

# Test the function with some input values
input_title <- "Example Question"
input_votes <- 10
input_text <- "This is an example question."
input_code <- list("code line 1", "code line 2")
input_answer_number <- 3

compatibility_result <- checkCompatibility(input_title, input_votes, input_text, input_code, input_answer_number)
print(compatibility_result)

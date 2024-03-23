get_tags <- function(){
    out = ""
    
    cat("Enter tags (leave empty for none, enter the tags splitted by a space for different tags (remember that multiple words tags are separated by a '-''): ")
    
    tags <- readLines("stdin", n=1)
    for (tag in unlist(strsplit(tags, " "))){
        out = paste0(out, "%5B", tag, "%5D+")
    }

    return (out)
}

get_ignore_tags <- function(){
    out = ""
    
    cat("Enter tags to ignore (leave empty for none, enter the tags splitted by a space for different tags (remember that multiple words tags are separated by a '-')): ")
    
    tags <- readLines("stdin", n=1)
    for (tag in unlist(strsplit(tags, " "))){
        out = paste0(out, "-", "%5B", tag, "%5D+")
    }

    return (out)
}

get_user <- function(){
    cat ("Enter the author id (number or \"me\" if you accessed stack overflow) you want to filter by (leave empty for none): ")
    user <- readLines("stdin", n=1)
    if (user == "") return ("")
    return (paste0("user%3A", user, "+"))
}

get_min_score <- function(){
    cat ("Enter the minimum score (integer) you want to filter the questions by (leave empty for none): ")
    minscore <- readLines("stdin", n=1)
    if (minscore == "") return ("")
    return (paste0("minscore%3A", minscore, "+"))
}

get_min_answer <- function(){
    # answer also has those parameters but they're not interesting
    # isaccepted:yes
    # hasaccepted:no
    # inquestion:1234
    cat ("Enter the minimum number of answers (integer) you want to filter the questions by (leave empty for none): ")
    minansw <- readLines("stdin", n=1)
    if (minansw == "") return ("")
    return (paste0("answer%3A", minansw, "+"))
}

get_min_view <- function(){
    cat ("Enter the minimum number of views (integer) you want to filter the questions by (leave empty for none): ")
    minviews <- readLines("stdin", n=1)
    if (minviews == "") return ("")
    return (paste0("views%3A", minviews, "+"))
}

get_code <- function(){
    cat ("Enter the code you want to filter the questions by (leave empty for none): ")
    code <- readLines("stdin", n=1)
    if (code == "") return ("")
    return (paste0("code%3A", combine_with_plus(code), "+"))
}

get_closed <- function(){   
    cat ("Enter yes or no to filter the questions by closed and not closed (leave empty or whatever else for none): ")
    closed <- readLines("stdin", n=1)
    if ((closed == "yes") || (closed == "no")) return (paste0("closed%3A", closed, "+"))
    return ("")
}

get_duplicated <- function(){   
    cat ("Enter yes or no to filter the questions by duplicate and not duplicate (leave empty or whatever else for none): ")
    duplicated <- readLines("stdin", n=1)
    if ((duplicated == "yes") || (duplicated == "no")) return (paste0("duplicate%3A", closed, "+"))
    return ("")
}

get_is_question <- function(){   
    cat ("Enter yes to filter the questions by the ones that have the search query in the question (leave empty or whatever else for none): ")
    is_question <- readLines("stdin", n=1)
    if (is_question == "yes") return (paste0("is%3A", "question", "+"))
    return ("")
}

get_is_answer <- function(){   
    cat ("Enter yes to filter the questions by the ones that have the search query in the answers (leave empty or whatever else for none): ")
    is_answer <- readLines("stdin", n=1)
    if (is_answer == "yes") return (paste0("is%3A", "answer", "+"))
    return ("")
}

# Function to apply search options to a start query
apply_search_options <- function(start_query) {
    return(
        paste0(
            start_query,
            get_tags(),
            get_ignore_tags(),
            get_user(),
            get_min_score(),
            get_min_answer(),
            get_min_view(),
            get_code(),
            get_closed(),
            get_duplicated(),
            get_is_question(),
            get_is_answer()
        )
    )
}

decide_if_search_options <- function (start_query){
    cat ("Do you want to apply search options to your query? (yes/no): ")
    decision = readLines("stdin", n = 1)
    if (decision == "yes") 
        return (apply_search_options(start_query)) 
    else 
        return (start_query)
}

combine_with_plus <- function(input_string) {
    # Replace spaces with '+' using gsub
    result = gsub(" ", "+", input_string)
    #have to add the + at the end since it does not change anything in the actual query and it is needed to concatenate other args
    paste0(result, "+")  
    
    return(result)
}

formulate_query <- function () {
    cat ("Please input the query without specifying any options except for the exact word option (putting the words you WANT to be there between \"word\"): ")
    initial_query = readLines("stdin", n = 1)  

    return (decide_if_search_options(combine_with_plus(initial_query)))
}


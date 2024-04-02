prompt_get_tags <- function(){  
    cat("Enter tags (leave empty for none, enter the tags splitted by a space for different tags (remember that multiple words tags are separated by a '-''): ")

    tags <- readLines("stdin", n=1)
    
    return (unlist(strsplit(tags, " ")))
}

prompt_get_ignore_tags <- function(){
    cat("Enter tags to ignore (leave empty for none, enter the tags splitted by a space for different tags (remember that multiple words tags are separated by a '-')): ")
    
    tags <- readLines("stdin", n=1)

    return (unlist(strsplit(tags, " ")))
}

prompt_get_user <- function(){
    cat ("Enter the author id (number or \"me\" if you accessed stack overflow) you want to filter by (leave empty for none): ")
    user <- readLines("stdin", n=1)
    return (user)
}

prompt_get_min_score <- function(){
    cat ("Enter the minimum score (integer) you want to filter the questions by (leave empty for none): ")
    minscore <- readLines("stdin", n=1)
    return (minscore)
}

prompt_get_min_answer <- function(){
    # answer also has those parameters but they're not interesting
    # isaccepted:yes
    # hasaccepted:no
    # inquestion:1234
    cat ("Enter the minimum number of answers (integer) you want to filter the questions by (leave empty for none): ")
    minansw <- readLines("stdin", n=1)
    return (minansw)
}

prompt_get_min_view <- function(){
    cat ("Enter the minimum number of views (integer) you want to filter the questions by (leave empty for none): ")
    minviews <- readLines("stdin", n=1)
    return (minviews)
}

prompt_get_code <- function(){
    cat ("Enter the code you want to filter the questions by (leave empty for none): ")
    code <- readLines("stdin", n=1)
    return (code)
}

prompt_get_closed <- function(){   
    cat ("Enter yes or no to filter the questions by closed and not closed (leave empty or whatever else for none): ")
    closed <- readLines("stdin", n=1)
    return (closed)
}

prompt_get_duplicated <- function(){   
    cat ("Enter yes or no to filter the questions by duplicate and not duplicate (leave empty or whatever else for none): ")
    duplicated <- readLines("stdin", n=1)
    return (duplicated)
}

prompt_get_is_question <- function(){   
    cat ("Enter yes to filter the questions by the ones that have the search query in the question (leave empty or whatever else for none): ")
    is_question <- readLines("stdin", n=1)
    return (is_question)
}

prompt_get_is_answer <- function(){   
    cat ("Enter yes to filter the questions by the ones that have the search query in the answers (leave empty or whatever else for none): ")
    is_answer <- readLines("stdin", n=1)
    return (is_answer)
}
source("queryOptionsPrompt.r")

get_tags <- function(tags){
    out = ""
    tags = paste (tags)

    for (tag in unlist(strsplit(tags, " "))){
        out = paste0(out, "%5B", tag, "%5D+")
    }

    return (out)
}

get_ignore_tags <- function(tags){
    out = ""
    tags = paste (tags)

    for (tag in unlist(strsplit(tags, " "))){
        out = paste0(out, "-", "%5B", tag, "%5D+")
    }

    return (out)
}

get_user <- function(user){
    if (user == "") return ("")
    return (paste0("user%3A", user, "+"))
}

get_min_score <- function(minscore){
    if (minscore == "") return ("")
    return (paste0("minscore%3A", minscore, "+"))
}

get_min_answer <- function(minansw){
    # answer also has those parameters but they're not interesting
    # isaccepted:yes
    # hasaccepted:no
    # inquestion:1234
    if (minansw == "") return ("")
    return (paste0("answer%3A", minansw, "+"))
}

get_min_view <- function(minviews){
    if (minviews == "") return ("")
    return (paste0("views%3A", minviews, "+"))
}

get_code <- function(code){
    if (code == "") return ("")
    return (paste0("code%3A", combine_with_plus(code), "+"))
}

get_closed <- function(closed){   
    if ((closed == "yes") || (closed == "no")) return (paste0("closed%3A", closed, "+"))
    return ("")
}

get_duplicated <- function(duplicated){   
    if ((duplicated == "yes") || (duplicated == "no")) return (paste0("duplicate%3A", duplicated, "+"))
    return ("")
}

get_is_question <- function(is_question){   
    if (is_question == "yes") return (paste0("is%3A", "question", "+"))
    return ("")
}

get_is_answer <- function(is_answer){   
    if (is_answer == "yes") return (paste0("is%3A", "answer", "+"))
    return ("")
}

# Function to apply search options to a start query
apply_search_options <- function(start_query, values) {
    return(
        paste0(
            start_query,
            get_tags(values[1]),
            get_ignore_tags(values[2]),
            get_user(values[3]),
            get_min_score(values[4]),
            get_min_answer(values[5]),
            get_min_view(values[6]),
            get_code(values[7]),
            get_closed(values[8]),
            get_duplicated(values[9]),
            get_is_question(values[10]),
            get_is_answer(values[11])
        )
    )
}

# Function to apply search options to a start query
apply_search_options_prompt <- function(start_query) {
    return(
        paste0(
            start_query,
            get_tags(prompt_get_tags()),
            get_ignore_tags(prompt_get_ignore_tags()),
            get_user(prompt_get_user()),
            get_min_score(prompt_get_min_score()),
            get_min_answer(prompt_get_min_answer()),
            get_min_view(prompt_get_min_view()),
            get_code(prompt_get_code()),
            get_closed(prompt_get_closed()),
            get_duplicated(prompt_get_duplicated()),
            get_is_question(prompt_get_is_question()),
            get_is_answer(prompt_get_is_answer())
        )
    )
}

decide_if_search_options <- function (start_query, values=""){
    if (class(values) == "character") 
        return (apply_search_options(start_query, values))
    else 
        return (apply_search_options_prompt(start_query)) 
}

combine_with_plus <- function(input_string) {
    # Replace spaces with '+' using gsub
    result = gsub(" ", "+", input_string)
    #have to add the + at the end since it does not change anything in the actual query and it is needed to concatenate other args
    paste0(result, "+")  
    
    return(result)
}

formulate_query <- function (initial_query, values) {
    if (initial_query == ""){
        cat ("Please input the query without specifying any options except for the exact word option (putting the words you WANT to be there between \"word\"): ")
        initial_query = readLines("stdin", n = 1)  

        return (decide_if_search_options(combine_with_plus(initial_query)))
    }
    return (decide_if_search_options(combine_with_plus(initial_query), values))
}


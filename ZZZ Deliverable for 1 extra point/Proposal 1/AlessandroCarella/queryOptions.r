# Function to apply search options to a start query
apply_search_options <- function(start_query) {
  cat("Enter search options:\n")
  
  # Prompt user for options
  tag <- readline(prompt = "Enter tag (leave empty for none): ")
  phrase <- readline(prompt = "Enter phrase in quotes (leave empty for none): ")
  title_search <- readline(prompt = "Search in title only? (yes/no): ")
  body_search <- readline(prompt = "Search in body only? (yes/no): ")
  code_search <- readline(prompt = "Search in code blocks only? (yes/no): ")
  user_posts <- readline(prompt = "Search only user posts? (yes/no): ")
  exclude_tag <- readline(prompt = "Exclude tag (leave empty for none): ")
  wildcard <- readline(prompt = "Use wildcard search? (yes/no): ")
  min_score <- readline(prompt = "Minimum score (leave empty for none): ")
  min_views <- readline(prompt = "Minimum views (leave empty for none): ")
  max_views <- readline(prompt = "Maximum views (leave empty for none): ")
  min_answers <- readline(prompt = "Minimum answers (leave empty for none): ")
  created <- readline(prompt = "Created after date (YYYY-MM-DD or relative, leave empty for none): ")
  last_active <- readline(prompt = "Last active after date (YYYY-MM-DD or relative, leave empty for none): ")
  user_id <- readline(prompt = "User ID for specific user posts (leave empty for none): ")
  is_accepted <- readline(prompt = "Only accepted answers? (yes/no): ")
  has_code <- readline(prompt = "Posts with code blocks? (yes/no): ")
  has_accepted <- readline(prompt = "Questions with accepted answers? (yes/no): ")
  is_answered <- readline(prompt = "Questions with positively-scored answers? (yes/no): ")
  is_closed <- readline(prompt = "Closed questions only? (yes/no): ")
  is_duplicate <- readline(prompt = "Duplicate questions only? (yes/no): ")
  is_migrated <- readline(prompt = "Migrated questions only? (yes/no): ")
  is_locked <- readline(prompt = "Locked posts only? (yes/no): ")
  has_notice <- readline(prompt = "Posts with notice only? (yes/no): ")
  is_wiki <- readline(prompt = "Community wiki posts only? (yes/no): ")
  collective <- readline(prompt = "Collective name (leave empty for none): ")
  is_article <- readline(prompt = "Search for articles only? (yes/no): ")
  deleted_posts <- readline(prompt = "Search deleted posts? (yes/no): ")
  staging_ground <- readline(prompt = "Search in Staging Ground posts? (yes/no): ")

  # Construct query based on user input
  query <- paste0(start_query,
                  if (tag != "") paste0(" [", tag, "]") else "",
                  if (phrase != "") paste0(" \"", phrase, "\"") else "",
                  if (title_search == "yes") " title:" else "",
                  if (body_search == "yes") " body:" else "",
                  if (code_search == "yes") " code:" else "",
                  if (user_posts == "yes") " user:me" else "",
                  if (exclude_tag != "") paste0(" -[", exclude_tag, "]") else "",
                  if (wildcard == "yes") "*" else "",
                  if (min_score != "") paste0(" score:", min_score) else "",
                  if (min_views != "") paste0(" views:", min_views) else "",
                  if (max_views != "") paste0("..", max_views) else "",
                  if (min_answers != "") paste0(" answers:", min_answers) else "",
                  if (created != "") paste0(" created:", created) else "",
                  if (last_active != "") paste0(" lastactive:", last_active) else "",
                  if (user_id != "") paste0(" user:", user_id) else "",
                  if (is_accepted == "yes") " isaccepted:yes" else "",
                  if (is_accepted == "no") " isaccepted:no" else "",
                  if (has_code == "yes") " hascode:yes" else "",
                  if (has_code == "no") " hascode:no" else "",
                  if (has_accepted == "yes") " hasaccepted:yes" else "",
                  if (has_accepted == "no") " hasaccepted:no" else "",
                  if (is_answered == "yes") " isanswered:yes" else "",
                  if (is_answered == "no") " isanswered:no" else "",
                  if (is_closed == "yes") " closed:yes" else "",
                  if (is_closed == "no") " closed:no" else "",
                  if (is_duplicate == "yes") " duplicate:yes" else "",
                  if (is_duplicate == "no") " duplicate:no" else "",
                  if (is_migrated == "yes") " migrated:yes" else "",
                  if (is_migrated == "no") " migrated:no" else "",
                  if (is_locked == "yes") " locked:yes" else "",
                  if (is_locked == "no") " locked:no" else "",
                  if (has_notice == "yes") " hasnotice:yes" else "",
                  if (has_notice == "no") " hasnotice:no" else "",
                  if (is_wiki == "yes") " wiki:yes" else "",
                  if (is_wiki == "no") " wiki:no" else "",
                  if (collective != "") paste0(" collective:\"", collective, "\"") else "",
                  if (is_article == "yes") " is:article" else "",
                  if (deleted_posts == "yes") " deleted:1" else "",
                  if (deleted_posts == "all") " deleted:all" else "",
                  if (staging_ground == "yes") " staging-ground:1" else "")
  
  return(query)
}

decide_if_search_options <- function (start_query){
    decision <- readline(prompt = "Do you want to apply search options to your query? (yes/no): ")
    if (decision == "yes") return apply_search_options(start_query) else return start_query,
}

# Example usage
# start_query <- "maintenance seat"

# # Apply search options to the start query
# result_query <- decide_if_search_options(start_query)

# cat("Resulting query:", result_query, "\n")

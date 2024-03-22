# Function to apply search options to a start query
apply_search_options <- function(start_query) {
  cat("Enter search options:\n")
  
  # Prompt user for options
  tag <- readline(prompt = "Enter tag (leave empty for none, default = no): ") || "no"
  phrase <- readline(prompt = "Enter phrase in quotes (leave empty for none, default = no): ") || "no"
  title_search <- readline(prompt = "Search in title only? (yes/no, default = no): ") || "no"
  body_search <- readline(prompt = "Search in body only? (yes/no, default = no): ") || "no"
  code_search <- readline(prompt = "Search in code blocks only? (yes/no, default = no): ") || "no"
  user_posts <- readline(prompt = "Search only user posts? (yes/no, default = no): ") || "no"
  exclude_tag <- readline(prompt = "Exclude tag (leave empty for none, default = no): ") || "no"
  wildcard <- readline(prompt = "Use wildcard search? (yes/no, default = no): ") || "no"
  min_score <- readline(prompt = "Minimum score (leave empty for none, default = no): ") || "no"
  min_views <- readline(prompt = "Minimum views (leave empty for none, default = no): ") || "no"
  max_views <- readline(prompt = "Maximum views (leave empty for none, default = no): ") || "no"
  min_answers <- readline(prompt = "Minimum answers (leave empty for none, default = no): ") || "no"
  created <- readline(prompt = "Created after date (YYYY-MM-DD or relative, leave empty for none, default = no): ") || "no"
  last_active <- readline(prompt = "Last active after date (YYYY-MM-DD or relative, leave empty for none, default = no): ") || "no"
  user_id <- readline(prompt = "User ID for specific user posts (leave empty for none, default = no): ") || "no"
  is_accepted <- readline(prompt = "Only accepted answers? (yes/no, default = no): ") || "no"
  has_code <- readline(prompt = "Posts with code blocks? (yes/no, default = no): ") || "no"
  has_accepted <- readline(prompt = "Questions with accepted answers? (yes/no, default = no): ") || "no"
  is_answered <- readline(prompt = "Questions with positively-scored answers? (yes/no, default = no): ") || "no"
  is_closed <- readline(prompt = "Closed questions only? (yes/no, default = no): ") || "no"
  is_duplicate <- readline(prompt = "Duplicate questions only? (yes/no, default = no): ") || "no"
  is_migrated <- readline(prompt = "Migrated questions only? (yes/no, default = no): ") || "no"
  is_locked <- readline(prompt = "Locked posts only? (yes/no, default = no): ") || "no"
  has_notice <- readline(prompt = "Posts with notice only? (yes/no, default = no): ") || "no"
  is_wiki <- readline(prompt = "Community wiki posts only? (yes/no, default = no): ") || "no"
  collective <- readline(prompt = "Collective name (leave empty for none, default = no): ") || "no"
  is_article <- readline(prompt = "Search for articles only? (yes/no, default = no): ") || "no"
  deleted_posts <- readline(prompt = "Search deleted posts? (yes/no, default = no): ") || "no"
  staging_ground <- readline(prompt = "Search in Staging Ground posts? (yes/no, default = no): ") || "no"

  # Construct query based on user input
  query <- paste0(start_query,
                  if (tag != "no") paste0(" [", tag, "]") else "",
                  if (phrase != "no") paste0(" \"", phrase, "\"") else "",
                  if (title_search == "yes") " title:" else "",
                  if (body_search == "yes") " body:" else "",
                  if (code_search == "yes") " code:" else "",
                  if (user_posts == "yes") " user:me" else "",
                  if (exclude_tag != "no") paste0(" -[", exclude_tag, "]") else "",
                  if (wildcard == "yes") "*" else "",
                  if (min_score != "no") paste0(" score:", min_score) else "",
                  if (min_views != "no") paste0(" views:", min_views) else "",
                  if (max_views != "no") paste0("..", max_views) else "",
                  if (min_answers != "no") paste0(" answers:", min_answers) else "",
                  if (created != "no") paste0(" created:", created) else "",
                  if (last_active != "no") paste0(" lastactive:", last_active) else "",
                  if (user_id != "no") paste0(" user:", user_id) else "",
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
                  if (collective != "no") paste0(" collective:\"", collective, "\"") else "",
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

library(jsonlite)

# Define a class with attributes as strings and a list of strings
setClass("MyClass",
         slots = list(attribute1 = "character",
                      attribute2 = "character",
                      list_attribute = "list"))

# Constructor function for MyClass
new_MyClass <- function(attribute1, attribute2, list_attribute) {
  return(new("MyClass",
             attribute1 = attribute1,
             attribute2 = attribute2,
             list_attribute = list_attribute))
}

# Create some instances of MyClass
obj1 <- new_MyClass("value1", "value2", list("item1", "item2"))
obj2 <- new_MyClass("value3", "value4", list("item3", "item4"))

# Combine the objects into a list
object_list <- list(obj1, obj2)

# Convert the list of objects to a dataframe
df <- data.frame(
  attribute1 = sapply(object_list, function(x) slot(x, "attribute1")),
  attribute2 = sapply(object_list, function(x) slot(x, "attribute2")),
  list_attribute = lapply(object_list, function(x) unlist(slot(x, "list_attribute"))),
  stringsAsFactors = FALSE
)

# Save the dataframe to a JSON file with an indent of 4
write_json(df, "objects.json", pretty = TRUE, digits = 4)

#
# This is a Plumber API. You can run the API by clicking
# the 'Run API' button above.
#
# Find out more about building APIs with Plumber here:
#
#    https://www.rplumber.io/
#

library(plumber)
library(AzureStor)
f = glue::glue


#* @apiTitle Plumber Example API
#* @apiDescription Plumber example description.

#* @get /env
env <- function(key = NULL) {
  as.list(Sys.getenv(key))
}

#* @get /nasa
env <- function() {
  as.list(Sys.getenv("NASA_KEY"))
}


#* @get /mtcars
env <- function() {
  blob_con = blob_endpoint(
    endpoint = f("https://asnrocksstorage.blob.core.windows.net/"),
    key = Sys.getenv('STORAGE_ACCOUNT_KEY')
  )

  container_client = blob_container(blob_con, name = "data")
  storage_read_csv(container_client, "mtcars.csv")
}




#* Echo back the input
#* @param msg The message to echo
#* @get /echo
function(msg = "") {
    list(msg = paste0("The message is: '", msg, "'"))
}

#* Plot a histogram
#* @serializer png
#* @get /plot
function() {
    rand <- rnorm(100)
    hist(rand)
}

#* Return the sum of two numbers
#* @param a The first number to add
#* @param b The second number to add
#* @post /sum
function(a, b) {
    as.numeric(a) + as.numeric(b)
}

# Programmatically alter your API
#* @plumber
function(pr) {
    pr %>%
        # Overwrite the default serializer to return unboxed JSON
        pr_set_serializer(serializer_unboxed_json())
}

# THIS SCRIPT CREATES THE ROXYGEN2 DOCUMENTATION SKELETON FOR ALL OF
# THE DATA SETS IN .CSV FILE FORMAT IN THE data-raw DIRECTORY

# go through all .csv files, and create a skeleton documentation in roxygen2
# format
for (file_name in dir("data-raw/")) {
  # current things going to write to file
  curr_line <- ""

  # skip if file doesn't end in .csv
  if (substr(file_name, nchar(file_name) - 3, nchar(file_name)) != ".csv") {
    next
  }

  # get name of data set
  data_set <- substr(file_name, 1, nchar(file_name) - 4)

  # load Rdata in other directory with same name
  load(paste("data/", data_set, ".Rda", sep=""))

  # print title line
  curr_line <- paste(curr_line, paste("#' The", data_set, "data set."), sep="\n")

  # print blank line
  curr_line <- paste(curr_line, "#' ", sep="\n")

  # print description line
  curr_line <- paste(curr_line, paste("#' The description of the", data_set, "data set."), sep="\n")

  # print blank line
  curr_line <- paste(curr_line, "#' ", sep="\n")

  # print format line with number of rows and columns
  curr_line <- paste(curr_line, paste("#' @format A data frame with",
      nrow(get(data_set)), "rows and", ncol(get(data_set)),
      "variables."),
    sep="\n")

  # print describe and items based on column names
  curr_line <- paste(curr_line, "#' \\describe{", sep="\n")
  for (col_name in names(get(data_set))) {
    curr_line <- paste(curr_line, paste("#'   \\item{", col_name,
      "}{variable}", sep=""), sep="\n")
  }
  curr_line <- paste(curr_line, "#' }", sep="\n")

  # print source line
  curr_line <- paste(curr_line, "#' @source \\url{http://people.kzoo.edu/enordmoe/math365/data/}", sep="\n")

  # print name of data set being described
  curr_line <- paste(curr_line, paste("\"", data_set,"\"" , sep=""),
    sep="\n")

  # remove data set from workspace
  # rm(data_set)

  # print documentation to file
  write(curr_line,
    file = "R/document_data.R", append = TRUE)

  # debug/update line
  print(data_set)
}

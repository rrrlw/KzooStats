# RAOUL R. WADHWA; 7 JUNE 2017
# THIS SCRIPT CAN BE RUN TO SAVE ALL THE DATA FROM THE CSV FILES IN THE
# data-raw DIRECTORY IN RDA FORM IN THE data DIRECTORY OF THE PACKAGE.
# THE data DIRECTORY SHOULD PREFERABLY BE EMPTY BEFOREHAND (BUT SHOULD
# EXIST).

# save all .csv files at once using the following two functions and
# some code below; fix data sets that don't conform manually after
save_file <- function(file_name) {
  assign(file_name,
    read_csv(paste("data-raw/",file_name,".csv", sep="")))
  save(list=file_name, file=paste("data/",file_name,".Rda",sep=""))
}

save_files <- function(name_list) {
  for (file_name in name_list) {
    print(file_name)  # used to debug; don't really need it
    save_file(file_name)
  }
}

# get list of files that we need to convert
# and remove file extension to get variable names, then save all
curr_files <- dir("data-raw/")
curr_files <- gsub("\\.csv", "", curr_files)
save_files(curr_files)

# fix the ones with missing columns (soccer14)
print("soccer14") # debug message
soccer14 <- readr::read_csv("data-raw/soccer14.csv")
soccer14 <- soccer14 %>% dplyr::select(League, Team, Goals) #ignore empty col
save(soccer14, file = "data/soccer14.Rda")

complete <- function(directory, id = 1:332) {
        ## 'directory' is a character vector of length 1 indicating
        ## the location of the CSV files

        ## 'id' is an integer vector indicating the monitor ID numbers
        ## to be used
        
        ## Return a data frame of the form:
        ## id nobs
        ## 1  117
        ## 2  1041
        ## ...
        ## where 'id' is the monitor ID number and 'nobs' is the
        ## number of complete cases

        output <- data.frame(id=numeric(), nobs=numeric())
        for(i in id) {
                fname <- sprintf("%s/%03d.csv", directory, i)
                data <- read.csv(fname, header = TRUE)
                res <- data$ID[!is.na(data$sulfate)&!is.na(data$nitrate)]
                output <- rbind(output, c(i, length(res)))
        }
        setNames(output, c("id","nobs"))
}
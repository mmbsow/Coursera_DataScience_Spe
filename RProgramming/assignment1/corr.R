corr <- function(directory, threshold = 0) {
        ## 'directory' is a character vector of length 1 indicating
        ## the location of the CSV files

        ## 'threshold' is a numeric vector of length 1 indicating the
        ## number of completely observed observations (on all
        ## variables) required to compute the correlation between
        ## nitrate and sulfate; the default is 0

        ## Return a numeric vector of correlations

        output <- numeric()
        v <- complete(directory)
        for(i in v$id[v$nobs>threshold]) {
                fname <- sprintf("%s/%03d.csv", directory, i)
                data <- read.csv(fname, header = TRUE)
                res <- cor(x=data$nitrate, y=data$sulfate, use="pairwise.complete.obs")
                output <- c(output, res)
        }
        output
}
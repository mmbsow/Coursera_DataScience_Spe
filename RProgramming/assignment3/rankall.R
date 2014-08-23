
getHospitalForRank <- function(state, num, dataset) {    
    ## subset data to only keep hospitals for the chosen state
    x <- subset(dataset, State == state)

    index <- 1
    if(is.numeric(num)) {
        index <- num
    }
    else if(num == "best") {
        index <- 1
    }
    else if(num == "worst"){
        index <- nrow(x)
    }
    
    hospital <- NA
    if(index <= nrow(x)) {
        hospital <- as.character(x[index,c("Hospital.Name")])
    }
    
    c(hospital, state)
}

rankall <- function(outcome, num = "best") {
    ## Read outcome data
    data <- read.csv("outcome-of-care-measures.csv", header = TRUE)
    
    ## Format outcome name
    o <- strsplit(outcome, " ")[[1]]
    o <- paste(toupper(substring(o, 1, 1)), tolower(substring(o, 2)), sep="", collapse=" ")
    o <- gsub(" ",".",o)
    if(!(o %in% c("Heart.Attack","Heart.Failure","Pneumonia"))) {
        stop("invalid outcome")
    }
    ## if gets here, then outcome name is valid, so we can build the column name
    outcome_col <- sprintf("Hospital.30.Day.Death..Mortality..Rates.from.%s", o)

    subdata <- data[,c("State", "Hospital.Name", outcome_col)]
    ## convert outcomes to numeric (suppress coercion warnings when 'Not Available')
    subdata[,outcome_col] <- suppressWarnings(as.numeric(as.character(subdata[,outcome_col])))
    ## get sort_order by outcome first and hospital name second, NA being ignored
    sort_order <- order(subdata[,outcome_col], subdata[,"Hospital.Name"], na.last = NA)
    sorted_data <- na.omit(subdata[sort_order,]) # removes the NA and sort x
    
    states <- c(state.abb, "DC", "VI")
    temp <- do.call(rbind, lapply(states[order(states)], getHospitalForRank, num, sorted_data))
    df <- data.frame(temp, row.names=temp[,2])
    names(df) <- c("hospital","state")
    df
}
us_states <- c("AL", "AK", "AZ", "AR", "CA", "CO", "CT", "DE", "FL", "GA", "HI", "ID", "IL", "IN", "IA", "KS", "KY", "LA", "ME", "MD", "MA", "MI", "MN", "MS", "MO", "MT", "NE", "NV", "NH", "NJ", "NM", "NY", "NC", "ND", "OH", "OK", "OR", "PA", "RI", "SC", "SD", "TN", "TX", "UT", "VT", "VA", "WA", "WV", "WI", "WY")

best <- function(state, outcome) {
        ## Read outcome data
        data <- read.csv("outcome-of-care-measures.csv", header = TRUE)

        ## Check that state and outcome are valid
        f_state <- toupper(state)
        if(!(f_state %in% us_states)) {
                stop("invalid state")
        }

        ## Format outcome name
        o <- strsplit(outcome, " ")[[1]]
        o <- paste(toupper(substring(o, 1, 1)), tolower(substring(o, 2)), sep="", collapse=" ")
        o <- gsub(" ",".",o)
        if(!(o %in% c("Heart.Attack","Heart.Failure","Pneumonia"))) {
                stop("invalid outcome")
        }
        ## if gets here, then outcome name is valid, so we can build the column name
        outcome_col <- sprintf("Hospital.30.Day.Death..Mortality..Rates.from.%s", o)

        ## subset data to only keep hospitals for the chosen state
        state_data <- subset(data, State == state)
        ## keep only hospital and outcome columns
        x <- state_data[,c("Hospital.Name",outcome_col)]
        ## convert outcomes to numeric (suppress coercion warnings when 'Not Available')
        x[,outcome_col] <- suppressWarnings(as.numeric(as.character(x[,outcome_col])))
        ## get sort_order by outcome first and hospital name second, NA being ignored
        sort_order <- order(x[,outcome_col], x[,"Hospital.Name"], na.last = NA)
        ## return the hospital name for the row with index = sort_order[1]
        as.character(x[sort_order[1],"Hospital.Name"])
}
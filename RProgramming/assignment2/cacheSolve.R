cacheSolve <- function(m, ...) {
        s <- m$getsolve()
        if(!is.null(s)) {
                message("getting cached data")
                return(s)
        }
        data <- m$get()
        s <- solve(data, ...)
        m$setsolve(s)
        s
}
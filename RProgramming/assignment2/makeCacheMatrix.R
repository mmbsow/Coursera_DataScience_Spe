makeCacheMatrix <- function(m = matrix()) {
        s <- NULL
        set <- function(k) {
                m <<- k
                s <<- NULL
        }
        get <- function() m
        setsolve <- function(solv) s <<- solv
        getsolve <- function() s
        list(set = set, get = get, setsolve = setsolve, getsolve = getsolve)
}
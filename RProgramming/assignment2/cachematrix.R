## This script contains 2 methods allowing to cache the inverse of a matrix:
## 1. makeCacheMatrix - creates a special "matrix" based on the matrix passed in as argument
## 2. cacheSolve - calculates the inverse of the special "matrix" created by makeCacheMatrix() 


## This method creates a special matrix, which keeps its inverse cached in the 's' variable
## It defines 4 methods to set/get the original matrix and to set/get its inverse.
## Input: matrix (empty matrix by default)
## Output: list of 4 functions to: set the value of the matrix, get the value of the matrix,
## set the value of the inverse, get the value of the inverse

makeCacheMatrix <- function(x = matrix()) {
        s <- NULL
        set <- function(k) {
                x <<- k
                s <<- NULL
        }
        get <- function() x
        setsolve <- function(solv) s <<- solv
        getsolve <- function() s
        list(set = set, get = get, setsolve = setsolve, getsolve = getsolve)
}


## This method calculates and returns the inverse of a special matrix 'x'
## It returns the cached inverse if available (i.e. not null)
## Else it computes the inverse and caches it in the special matrix via the
## setsolve() function
## Input: special matrix, other arguments for the solve() function
## Output: inverse of the matrix passed in the input

cacheSolve <- function(x, ...) {
        s <- x$getsolve()
        if(!is.null(s)) {
                message("getting cached data")
                return(s)
        }
        data <- x$get()
        s <- solve(data, ...)
        x$setsolve(s)
        s
}

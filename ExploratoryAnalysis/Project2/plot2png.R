# function printing a ggplot2 graph to a png file
plot2png <- function(theplot, name, ...) {
    name <- paste0(name, ".png")
    png(filename=name)
    print(theplot)
    dev.off()
} #plotting function

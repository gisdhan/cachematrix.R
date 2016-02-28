corr <- function(directory, threshold = 0) {
    ## 'directory' is a character vector of length 1 indicating
    ## the location of the CSV files
    
    ## 'threshold' is a numeric vector of length 1 indicating the
    ## number of completely observed observations (on all
    ## variables) required to compute the correlation between
    ## nitrate and sulfate; the default is 0
    
    ## Return a numeric vector of correlations
    
    if(grep("specdata", directory) == 1) {
        directory <- ("./specdata/")
    }
    # get the complete table
    complete_table <- complete("specdata", 1:332)
    nobs <- complete_table$nobs
    # find the valid ids
    ids <- complete_table$id[nobs > threshold]
    # get the length of ids vector
    id_len <- length(ids)
    corr_vector <- rep(0, id_len)
    # find all files in the specdata folder
    all_files <- as.character( list.files(directory) )
    file_paths <- paste(directory, all_files, sep="")
    j <- 1
    for(i in ids) {
        current_file <- read.csv(file_paths[i], header=T, sep=",")
        corr_vector[j] <- cor(current_file$sulfate, current_file$nitrate, use="complete.obs")
        j <- j + 1
    }
    result <- corr_vector
    return(result)   
}
    ## test
        > source("corr.R")
        Error in file(filename, "r", encoding = encoding) : 
          cannot open the connection
        In addition: Warning message:
        In file(filename, "r", encoding = encoding) :
          cannot open file 'corr.R': No such file or directory
        > source("complete.R")
        Error in file(filename, "r", encoding = encoding) : 
          cannot open the connection
        In addition: Warning message:
        In file(filename, "r", encoding = encoding) :
          cannot open file 'complete.R': No such file or directory
        > cr <- corr("specdata", 150)
        > head(cr)
        [1] -0.01895754 -0.14051254 -0.04389737 -0.06815956 -0.12350667 -0.07588814
        >  summary(cr)
            Min.  1st Qu.   Median     Mean  3rd Qu.     Max. 
        -0.21060 -0.04999  0.09463  0.12530  0.26840  0.76310
        > cr <- corr("specdata", 400)
        > head(cr)
        [1] -0.01895754 -0.04389737 -0.06815956 -0.07588814  0.76312884 -0.15782860
        > cr <- corr("specdata", 5000)
        > summary(cr)
           Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
        
        > length(cr)
        [1] 0
        > cr <- corr("specdata")
        > summary(cr)
            Min.  1st Qu.   Median     Mean  3rd Qu.     Max. 
        -1.00000 -0.05282  0.10720  0.13680  0.27830  1.00000 
        > 
        > length(cr)
        [1] 323
        > 


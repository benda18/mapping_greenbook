library(dplyr)

get_decade <- function(yr1){
  require(dplyr)
  if(is.character(yr1)){
    yr1 <- as.numeric(unlist(strsplit(yr1, ""))) %>%
      .[!is.na(.)] %>%
      paste(., sep = "", collapse = "") %>%
      as.numeric()
  }
  
  if(nchar(yr1) == 4){
    yr1 <- yr1 - 1900
  }
    out <- paste((floor(yr1/10)*10)+1900,"s", sep = "")
 return(out) 
}



p.dal <- function(txt = "2nd Avenue Motel
Address: 214 Long Street (Location unknown)
Years Listed: 1956-57
Status: Unknown"){
  require(readr)
  require(janitor)
  library(data.table)
  temp       <- read_lines(txt)
  temp[1]    <- paste("Name: ", temp[1], sep = "")
  temp.names <- gsub(pattern = ":.*$", "", temp)
  temp       <- trimws(gsub(pattern = "^.*:", "", temp))
  
  temp <- as.data.frame(t(data.frame(temp)))
  names(temp) <- temp.names
  
  temp <- clean_names(temp)
  
  # tidy
  temp$address <- trimws(gsub("\\(.*$", "", temp$address))
  temp$address <- paste(temp$address, "Dallas TX", sep = ", ")
  
  temp.decades <-  lapply(X = unlist(strsplit(x = temp$years_listed, "-")), 
                          FUN = get_decade) %>%
    unlist() %>%
    unique() %>%
    gsub("s$", "", .)
  
  temp.decades <- seq(min(temp.decades), 
                      max(temp.decades), 
                      by = 10) 
  
  
  
  temp$d1930s <- "1930s" %in% get_decade(temp.decades)
  temp$d1940s <- "1940s" %in% get_decade(temp.decades)
  temp$d1950s <- "1950s" %in% get_decade(temp.decades)
  temp$d1960s <- "1960s" %in% get_decade(temp.decades)
  
  temp <- temp[colnames(temp) %in% c("name", "address", 
                                      "d1930s", 
                                      "d1940s",
                                      "d1950s",
                                      "d1960s")]
  
  temp <- temp %>%
    as.data.table() %>%
    melt(., 
         measure.vars = c("d1930s", 
                        "d1940s",
                        "d1950s",
                        "d1960s")) %>%
    as.data.frame() %>%
    as_tibble() %>%
    .[.$value,] %>%
    .[!colnames(.) %in% "value"]
  
  temp$variable <- as.character(temp$variable) %>%
    gsub(pattern = "^d", "", .)
  
  colnames(temp)[colnames(temp) == "variable"] <- "decade"
  colnames(temp)[colnames(temp) == "name"] <- "Name"
  colnames(temp)[colnames(temp) == "address"] <- "Address"
  
  temp
  return(temp)
}

p.dal()

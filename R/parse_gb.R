library(dplyr)

rm(list=ls());cat('\f')

"https://cityofdallaspreservation.wordpress.com/2019/01/22/dallas-green-book-listings/"

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
Status: Unknown", city = "Dallas", state = "TX"){
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
  temp$address <- temp$address %>%
    gsub("1815 Orange Street \\(now ", 
         "1815 ", .) %>%
    gsub("\\)$", "", .)
  
  temp$address <- temp$address %>%
    gsub("2700 Flora St \\(now ", 
         "2700 ", .) %>%
    gsub("\\)$", "", .)
  
  temp$address <- temp$address %>%
    gsub("\\(.*\\)", "", .)
  
  temp$address <- trimws(gsub("\\(.*$", "", temp$address))
  temp$address <- paste(temp$address, "Dallas TX", sep = ", ")
  
  temp.decades <-  lapply(X = unlist(strsplit(x = temp$years_listed, "-|,")), 
                          FUN = get_decade) %>%
    unlist() %>%
    unique() %>%
    gsub("s$", "", .) %>%
    as.numeric()
  
  temp.decades <- seq(min(temp.decades), 
                      max(temp.decades), 
                      by = 10)
  
  temp$d1930s <- "1930s" %in% unlist(lapply(temp.decades, get_decade))
  temp$d1940s <- "1940s" %in% unlist(lapply(temp.decades, get_decade))
  temp$d1950s <- "1950s" %in% unlist(lapply(temp.decades, get_decade))
  temp$d1960s <- "1960s" %in% unlist(lapply(temp.decades, get_decade))
  
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
  temp$City <- city
  temp$State <- state
  
  # Types
  temp$Type <- NA
  
  if(grepl("\\(.*\\)$", first(temp$Name))){
    try(temp$Type <- unique(temp$Name) %>%
          gsub("^.*\\(|\\)$", "", .))
  }
  
  temp$Type[is.na(temp$Type) & 
              grepl(pattern = "motel|hotel", 
                    x = temp$Name, ignore.case = T)] <- "hotel"
  temp$Type[is.na(temp$Type) & 
              grepl(pattern = "restaurant|cafe", 
                    x = temp$Name, ignore.case = T)] <- "restaurant"
  
  # Name
  temp$Name <- gsub("\\(.*\\)", "", temp$Name) %>% trimws()
  return(temp)
}




# run it----
the.dallas <- c("2nd Avenue Motel
Address: 214 Long Street (Location unknown)
Years Listed: 1956-57
Status: Unknown", 
       "8th Street Motel
Address: 1937 8th Street (Location unknown)
Years Listed: 1956
Status: Unknown", 
       "Beaumont Barbeque (Restaurant)
Address: 1815 Orange Street (now Field Street)
Years Listed: 1941-67
Status: Demolished", 
       "Bogel Hotel
Address: 821 Bogel St
Years Listed: 1955-67
Status: Demolished", 
       "Davis (Restaurant)
Address: 6806 Lemmon Ave
Years Listed: 1941-55
Status: Demolished", 
       "Foster’s Motel
Address: 903 Liberty
Years Listed: 1959-61
Status: Demolished",
       
       "Givens (Garage)
Address: 3102 Ross Ave
Years Listed: 1941-48
Status: Demolished",
       
       "Grand Terrace (Hotel)
Address: Boll and Guliett (Juliette)
Years Listed: 1941-52
Status: Demolished", 
       "Green Acres Motel
Address: 1711 McCoy St
Years Listed: 1956-67
Status: Demolished (2017)", 
       "Hall St (Tavern)
Address: 1804 Hall St (address numbers have changed since publication)
Years Listed: 1941-51
Status: Demolished", 
       "Hall’s (Hotel)
       Address: 1825 Hall St (address numbers have changed since publication)
       Years Listed: 1941-55
       Status: Demolished",
       
       "Irene’s (Restaurant)
       Address: 3209 Thomas
       Years Listed: 1941
       Status: Demolished",
       
      "Jack’s (Service Station)
       Address: Hall and Central
       Years Listed: 1941
       Status: Demolished",
       
       "Johnson’s Eat Shop (Restaurant)
       Address: 2306 Allen St
       Years Listed: 1959-61
       Status: Demolished",
       
       "Lewis (Hotel)
       Address: 302 N Central (address numbers have changed since publication)
       Years Listed: 1941-61
       Status: Demolished",
       
       "Little State Hotel
       Address: 3212 State St
       Years Listed: 1959-61
       Status: Demolished",
       
       "Lone Star / Howard Hotel
       Address: 3118 San Jacinto
       Years Listed: 1941-67
       Status: Demolished
       Note: Name changed to Howard by 1952 listing", 
      
      "Moorland Y.M.C.A. (Lodging, community center)
Address: 2700 Flora St (now Ann Williams Way)
Years Listed: 1941-67
Status: Standing
Note: Now the Dallas Black Dance Theater",
      
      "Palm Cafe
      Address: 2213 Hall St (address numbers have changed since publication)
      Years Listed: 1941-57
      Status: Demolished",
      
      "Peter Lane Hotel
      Address: 2611 Flora St
      Years Listed: 1959-61
      Status: Demolished",
      
      "Powell Hotel
      Address: 3115 State St
      Years Listed: 1941-67
      Status: Demolished",
      
      "Regal (Night Club)
      Address: Thomas Ave and Hall St
      Years Listed: 1941, 1946
      Status: Demolished",
      
      "S. Brown’s (Beauty salon)
      Address: 1721 Hall St (address numbers have changed since publication)
      Years Listed: 1941-55
      Status: Demolished",
      
      "Shalimar Restaurant
      Address: 2219 Hall St (address numbers have changed since publication)
      Years Listed: 1953-67
      Status: Demolished",
      
      "Smith’s (Drug store)
      Address: Corner of Hall St and Thomas Ave
      Years Listed: 1941-55
      Status: Demolished",
      
      "State (Taxicabs)
      Address: 2411 Elm St
      Years Listed: 1941
      Status: Demolished",
      
      "Tommie & Fred’s (Restaurant)
      Address: Washington St and Thomas Ave
      Years Listed: 1941-47
      Status: Demolished", 
      
      "Triple A Motel
Address: 1839 Fort Worth Ave
Years Listed: 1956-61
Status: Standing
Note: Now the Inn of the Dove", 
      
      "Walker’s (Service Station)
      Address: 2307 Hall St (address numbers have changed since publication)
      Years Listed: 1941
      Status: Demolished",
      
      "Washington’s (Barber shop)
      Address: 3203 Thomas Ave (address numbers have changed since publication)
      Years Listed: 1941-55
      Status: Demolished",
      
     "William’s (Service Station)
      Address: Lennard & Thomas Ave
      Years Listed: 1941
      Status: Demolished",
      
      "William’s Motel
      Address: 6007 Harry Hines Blvd
      Years Listed: 1959-61
      Status: Demolished",
      
      "Y.W.C.A. (Lodging, community center)
      Address: 3525 State St
      Years Listed: 1941-67
      Status: Demolished"
      )


dal.df <- NULL
for(i in 1:length(the.dallas)){
  dal.df <- rbind(dal.df, 
                  p.dal(the.dallas[i]))
  

}

dal.df
tail(dal.df)


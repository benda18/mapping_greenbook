library(renv)
library(readxl)
library(xlsx)
#library(remotes)
#library(censusxy)
#remotes::install_github("chris-prener/censusxy")
library(janitor)


renv::snapshot()
renv::status()

rm(list=ls());cat('\f')
gc()

# read spreadsheet----

gb <- readxl::read_xlsx(path = "data/greenbook_addresses.xlsx")

gb$oneline <- paste(gb$Address, 
                    gb$City, 
                    gb$State, sep = ", ")

for(i in 1:nrow(gb)){
  if(is.na(gb$cen_addr[i])){
    print(i)
    temp <- censusxy::cxy_oneline(gb[i,]$oneline)
    if(is.null(temp)){
      gb$cen_addr[i] <- "[none found]"
    }else{
      gb$cen_addr[i]   <- temp$matchedAddress
      gb$cen_city[i]   <- temp$addressComponents.city
      gb$cen_lon[i]    <- temp$coordinates.x
      gb$cen_lat[i]    <- temp$coordinates.y
      gb$cen_state[i]  <- temp$addressComponents.state
      gb$cen_street[i] <- temp$addressComponents.streetName
      gb$cen_zip[i]    <- temp$addressComponents.zip
      
    }
  }
  rm(temp)
}

# remove leading rows and write to file
xlsx::write.xlsx(x = gb[,!grepl("^\\.", colnames(gb))], 
                 file = "data/greenbook_addresses.xlsx")
rm(gb)


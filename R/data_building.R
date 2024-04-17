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


# gbsum <- read_xlsx("data/greenbook_citysummary.xlsx")


# OLDER----
# read spreadsheet

gb <- readxl::read_xlsx(path = "data/greenbook_addresses.xlsx")

#gb <- full_join(gb, okla2)
#gb <- full_join(gb, dal.df)



gb$Address <- gsub(", Dallas TX$", "", gb$Address)

gb$oneline <- paste(gb$Address,
                    gb$City,
                    gb$State, sep = ", ")

# tidy
gb$Type <- tolower(gb$Type)
gb$Type[gb$Type == "tourist"] <- "private residence"

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
gb <- gb[,!grepl("^\\.", colnames(gb))] %>% .[!duplicated(.),]

# remove leading rows and write to file
xlsx::write.xlsx(x = gb,
                 file = "data/greenbook_addresses.xlsx")
# xlsx::write.xlsx(x = gb[,!grepl("^\\.", colnames(gb))],
#                  file = "shiny_remaining_greenbook_addresses/greenbook_addresses.xlsx")


saveRDS(object = gb, 
        file = "shiny_remaining_greenbook_addresses/greenbook_addresses.rds")

rm(gb)



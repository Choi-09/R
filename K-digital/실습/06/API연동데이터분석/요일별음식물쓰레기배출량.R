library(jsonlite)

apikey <- "PQi11paHpvLD24fmnFARp6n5mpwa5XnPfvoV6MAp3%2FHaGsAREgCTsgptpidQ%2FM0h09G9qU%2FWNybUnNnK05QH9g%3D%3D"

url <- paste("http://apis.data.go.kr/B552584/RfidFoodWasteServiceNew/getTotalDayList?",
              "ServiceKey=", apikey,
              "&type=json&page=1&rowNum=10",
              "&disYear=", year,
              "&disMonth=", month, sep = '')
url

food_waste <- fromJSON(url)
food_waste

info <- food_waste$data$list

str(info)

# numlist <-c('disYear', 'disMonth')
# for (i in numlist){
#   info[i] <- as.numeric(unlist(info[i]))
# }
#   
# info

info$disDay <- c( '일','월', '화', '수', '목','금', '토')
head(info)

names(info) <- c('배출년', '배출월', '배출요일', '요일갯수', '배출량', '일평균배출량', '배출횟수', '일평균배출횟수')


waste_detail <- function(year, month){
  apikey <- "PQi11paHpvLD24fmnFARp6n5mpwa5XnPfvoV6MAp3%2FHaGsAREgCTsgptpidQ%2FM0h09G9qU%2FWNybUnNnK05QH9g%3D%3D"
  
  url <- paste("http://apis.data.go.kr/B552584/RfidFoodWasteServiceNew/getTotalDayList?",
               "ServiceKey=", apikey,
               "&type=json&page=1&rowNum=10",
               "&disYear=", year,
               "&disMonth=", month, sep = '')
  food_waste <- fromJSON(url)
  info <- food_waste$data$list
  info$disDay <- c( '일','월', '화', '수', '목','금', '토')
  names(info) <- c('배출년도', '배출월', '배출요일', '요일갯수', '배출량', '일평균배출량', '배출횟수', '일평균배출횟수')
  return(info)
}

data1 <- waste_detail("2022", "08")
data2 <- waste_detail("2021", "08")
data3 <- waste_detail("2020", "08")

data1
data2
data3

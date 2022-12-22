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

# 3년치 데이터 추출
data2020 <- waste_detail("2022", "08")
data2021 <- waste_detail("2021", "08")
data2022 <- waste_detail("2020", "08")

# 데이터 합치기  
dt <- rbind(data2020, data2021, data2022)  # bind_rows()
t(dt)

# for문을 통해서 1년치 데이터 끌어오기 
dft2021 <- data.frame() ;

for(i in 1:12){
  if (i < 10) {
    m = paste('0',i,sep='')
  }
  else m = as.character(i);
  temp <-waste_detail("2021", m)
  dft2021 <- bind_rows(dft2021, temp)
}

str(dft2021)

# EDA 
# 요일별 일평균배출량 
library(dplyr)
library(tibble)
day_dayavg <- dt %>% group_by(배출년도,배출요일) %>% summarise(sum(일평균배출량/1000000))
print(day_dayavg, n = nrow(dt))


# 데이터 열 생성(새로운 방법) mutate() : 열 생성 
dt <- dt %>% 
  mutate(disWeek = case_when(disDay == 1 ~ "일",
                             disDay == 2 ~ "월",
                             disDay == 3 ~ "화",
                             disDay == 4 ~ "수",
                             disDay == 5 ~ "목",
                             disDay == 6 ~ "금",
                             disDay == 7 ~ "토",))


#그래프
# 1) 요일별 일평균 배출량 
ggplot(data=dt, aes(x= 배출요일, y=일평균배출량/100000000, group=배출년도, col = 배출년도)) +
  geom_line()+
  geom_point()+
  ggtitle('요일별 일평균배출량')+
  theme(plot.title = element_text(hjust =0.5,size=20,face='bold'))+
  scale_x_discrete(limits=c('일','월','화','수','목','금','토'))

# scale_y_continuous(limits = c(0, 1000000))


# 2) 2021년도 월별 배출량
f1 <- ggplot(dft2021, aes(x=배출요일, y=배출량, fill = 배출요일)) + 
  geom_boxplot() +
  ggtitle("2021년도 월별 음식물쓰레기 배출량")+
  theme()
f1


# 3) 2021년도 월별 배출횟수 
dft2021_monthly_freq %>% ggvis(~배출월, ~배출횟수평균, fill = ~배출월 ) %>%
        layer_bars()%>%
        add_axis("x", title ="배출 월") %>%
        add_axis("y", title = "평균 배출횟수") 
 
dft2021_monthly_freq <- dft2021 %>% group_by(배출월) %>% summarise(mean(배출횟수)/1000000) 
names(dft2021_monthly_freq) <- c('배출월', '배출횟수평균')
dft2021_monthly_freq

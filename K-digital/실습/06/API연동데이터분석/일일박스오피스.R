# json 처리 패키지 
install.packages("jsonlite")
library(jsonlite)


# API  url 주소를 문자열로 만들기  
apikey <- "f5eef3421c602c6cb7ea224104795888"
dt <- "20221220"
url <- paste("http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?",
               "key=", apikey, 
               "&targetDt=", dt, sep='')
url

# 영화 데이터 가져오기 
mv <- fromJSON(url)
mv

class(mv)  # list 타입이기 때문에 $ 로 경로찾을수 있다. 
mode(mv)

# 박스오피스 목록 추출 
lst <- mv$boxOfficeResult$dailyBoxOfficeList
return(lst)


mvlist(20221110)
# 필요한 데이터 추출
names(lst)
str(lst)
lst$openDt <- as.Date(lst$openDt)

info <- c("rnum", 'rank', 'rankInten', 'salesAmt', 'salesShare', 'salesInten', 'salesChange', 'salesAcc',
          'audiCnt', 'audiInten', 'audiChange', 'audiAcc', 'scrnCnt', 'showCnt')

# chr 타입 num으로 바꾸기 
for (i in info) {
  lst[i] <- as.numeric(unlist(lst[i]))  # lst[c]: 리스트로 출력되는데 for문은 vector로 바꿔줘야해서.
}
str(lst)

# 매출 평균보다 매출이 높은 영화
library(dplyr)
# lst$topSales <- lst$salesAmt > mean(lst$salesAmt)
lst %>% filter(salesAmt > mean(lst$salesAmt)) %>%
                 select(rank, movieNm, salesAmt)
head(lst)

# =============================================================================
# 날짜 입력하면 해당 요일의 영화 목록 호출 함수 
mvlist <- function(date){
  apikey <- "f5eef3421c602c6cb7ea224104795888"
  url <- paste("http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?",
               "key=", apikey, 
               "&targetDt=", date, sep='')
  mv <- fromJSON(url)
  lst <- mv$boxOfficeResult$dailyBoxOfficeList
  return(data.frame(lst))
}
# 함수 호출 
mvlist(20221110)
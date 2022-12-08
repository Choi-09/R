# 1. 파일 읽어오기 
setwd("C:/RWork/실습/02")
data <- read.csv("02_부산광역시_지방세 체납현황.csv", header = T, fileEncoding = "euc-kr")
head(data)
tail(data)

# 2. 데이터를 데이터프레임에 넣기 
df <- data.frame(data)
head(df)

names(df)

# 3. 필요한 열 정리 
df <- df[c("과세년도", "세목명", "체납액구간", "누적체납건수", "누적체납금액")]
head(df)


# 4. 세목명 중복제거 
cols = unique(df$세목명)  #unique(): 중복제거
cols


# 5. 과세년도를 범주형으로 바꾸기 
df$체납액구간 <- as.factor(df$체납액구간)  #as.factor(): 수치형데이터가 범주형으로 바뀐다.


# 6. 함수 만들기*** 
makedf <- function(item) {
  temp <- subset(df, df$세목명 == item)  # df의 세목명이 입력하는 item과 같으면 
  ggplot(mapping =aes(x=과세년도, y=누적체납건수, fill=체납액구간), data=temp) +
    geom_bar(stat="identity", position=position_dodge()) +
    ggtitle(item)+                       # 그래프 작성 
    theme(plot.title = element_text(hjust = 0.5,size=20,face='bold')) 
}
makedf("자동차세")  



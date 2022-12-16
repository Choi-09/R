setwd("C:/RWork/실습/03.치매환자현황분석")
data <- read.csv("03_치매환자현황.csv", header = T, fileEncoding = 'euc-kr')

head(data)
summary(data)

df <- data.frame(data)
df

summary(df)

# 1. 거주지역별 치매환자 빈도표를 구하고 그래프 작성(qplot()) 
tb1 <- table(df$거주지역)
tb1

tb2 <- table(df$성별)
tb2


tb1 <- as.data.frame(tb1)
class(tb1)
tb1

install.packages("ggplot2")
library(ggplot2)

qplot(거주지역, data=df, fill=거주지역 ) + 
  ggtitle("거주지역별 치매환자") +
  theme(plot.title = element_text(hjust = 0.5, size = 20, face = 'bold' ))



# 2. 기준일자와 진단일자를 이용하여 진단일수를 계산하고 평균 진단일수 산출
head(df)
# 날짜 형식 변환
dateStd <- as.Date(df$데이터기준일자)
date <- as.Date(df$진단일자)

days <-difftime(df$데이터기준일자, df$진단일자, units = 'days')

## 진단일수
df$진단일수 <- days
df

## 평균 진단일수
mean(df$진단일수)


# 3. 연령대별 빈도수 그래프를 그려서 치매환자가 많은 연령대 분석

## 진단년도 추출
install.packages("lubridate")  # lubridate: 날짜처리 패키지 
library("lubridate")
df
df$데이터기준일자
df$진단년도 <-  year(df$진단일자)

df$진단년도
df

# 환자 나이 추출
df$나이 <-df$진단년도- df$출생년도
df$나이
df

# 연령대 구하기
df$연령대 <- (df$나이 %/% 10) * 10
df$연령대
df$연령대 <- paste(df$연령대, "대", sep = "")   #paste: 데이터 값에 붙인다. # sep: 공백제거에 사용 
df


## 연령대별 빈도수 그래프를 그려서 치매환자가 많은 연령대 분석
table(df$연령대)

## 100세 데이터 제외
subset(df, df$연령대 == "100대")  
df$연령대 <- ifelse(df$연령대 == "100대", "90대", df$연령대)
df
qplot(연령대, data=df, fill=연령대 ) + 
  ggtitle("연령별 치매환자") +
  theme(plot.title = element_text(hjust = 5, size = 20, face = 'bold' ))

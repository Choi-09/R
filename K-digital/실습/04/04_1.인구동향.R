
#인구 동향
library(dplyr)

# 1. 데이터 불러오기(인구동향)
setwd("C:/RWork/실습/04")
data <- read.csv("04_인구동향.csv", fileEncoding = "euc-kr", header = T, )
df <- data.frame(data)
df

# 2. 열명 확인
names(df)

# 3. 열명 수정 "행정구역별","시점","출생아수","사망자수","혼인건수","이혼건수"
names(df)  <- c( "행정구역","시점","출생아수","사망자수","혼인건수","이혼건수")
head(df)
tail(df)

# EDA (탐색적 데이터 분석)
# 데이터 구조 확인
str(df)

# 범주형 변경: 시점 int -> category 
df$시점 <- as.factor(df$시점)
mode(df$시점)  # 데이터 형태
class(df$시점)  # 데이터 타입 

# 4. 결측치 확인
sum(is.na(df))  # 결측치 갯수 
colSums(is.na(df))   # 컬럼별 결측치 갯수 

summary(df)

library(dplyr)
#결측치 내용 확인 
df_na <-  df %>% filter(is.na(df$출생아수))  # True만 filter해서 저장하겠다~
df_na

# 결측치가 같은 행에 들어가 있으므로 각각 따로 df를 만들지 않아도 된다.
#df_nd <- df %>% filter(is.na(df$사망자수))
#df_nd
#df_dv <- df %>% filter(is.na(df$이혼건수))
#df_dv
#df_mr <- df %>% filter(is.na(df$혼인건수))
#df_mr

unique(df_na$행정구역)
unique(df_na$시점)

#결측치 행 제거
df3 <- na.omit(df)
df3
 
#결측치 확인
sum(is.na(df)) 
colSums(is.na(df))
summary(df3)

#결측치 값 대체(1)
df4 <- df
df4$출생아수 <- ifelse(is.na(df4$출생아수), 0, df4$출생아수) 
df <- df %>% replace(is.na(df), 0)  # 전체 na 값을 0으로 대체 


# 결측치 값 대체(2) 
# "출생아수", "사망자수, "혼인건수", "이혼건수"에 대해서 na를 0으로 변경(반복문 사용) 
col <- names(df4)[3:6]

for(i in col) {
  temp <- df[,i]  # 모든 열을 돌면서 temp에 담기
  temp <- ifelse(is.na(temp), 0,temp)   # temp에 na값이 있으면 0, 아니면 기존 temp값.
  df[,i] <- temp  # 다시 temp를 df에 담기 
}

summary(df)


# 자연증가수 
df4$자연증가수 <- df4$출생아수 - df4$사망자수
head(df4) 

# 전국적으로 자연증가수 감소가 시작되는 연도는?
# (case 1)=====
r <- which(df4$행정구역 == '전국' & df4$자연증가수<0)
df4[r,]['시점'][1,1]

df[which(df4$행정구역 == '전국' & df4$자연증가수<0),]['시점']

# (case 2)=====
df[df4$행정구역 =='전국' & df4$자연증가수 <0,]['시점']

# (case 3)=====
df4 %>% filter(df4$행정구역 == '전국' & df4$자연증가수 <0) %>% select('시점')

# 기술통계분석-범주형자료-빈도분석
table(df$행정구역)
table(df$시점)

# 기술통계분석-연속형자료-요약 통계량
summary(df$출생아수)

# 기술통계분석-연속형자료-산점도 통계량
plot(df$출생아수, df$혼인건수)

# 전국 자료와 지역자료 분리
df_lc <- df4 %>% filter(df4$행정구역 != '전국')
df_a <- df4 %>% filter(df4$행정구역 == '전국')

df_lc
df_a

#데이터 분석


# 전국데이터 자연 증가수 그래프
ggplot(mapping =aes(x=시점, y=자연증가수, fill=자연증가수), data=df_a) +
  geom_bar(stat="identity", position=position_dodge()) +
  ggtitle('전국 출생아 자연증가수')+
  theme(plot.title = element_text(hjust = 0.5,size=20,face='bold'))
  

library(ggplot2)
  



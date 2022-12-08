# 1. 라이브러리 설치
install.packages("readxl")
library(readxl)

# 2. 작업파일 경로 설정
setwd("C:/RWork/실습/02")

# 3. 파일 읽어오기
data <- read_excel(path = './02_역주행사고.xlsx', sheet = 'Sheet2')
data

# 4. 데이터프레임에 넣기
df <- data.frame(data)
df

df$치명률 <- round((df$사망 / df$사고)*100,2)
df

# 5. 테이블 분리
df1 <- subset(df, df$구분 == "전체")
df1

df2 <- df[df$구분 == "역주행", ]  # , 반드시 사용!
df2

# 6. 일반 사고 데이터 만들기
df3 <- df1
df3

df3$구분 = c('일반')
df3

df3[c('사고', '사망')] <- df1[c('사고', '사망')] - df2[c('사고', '사망')]
df3

df3$치명률 <- round((df3$사망 / df3$사고)*100,2)
df3


# 7. 기초 통계값
summary(df2)
mean(df2$치명률)


#3년 평균 사고건수
# cat(): 문자열 합쳐준다.
cat("\"최근 3년간 역주행 교통사고의 치명률이", 
    round(mean(df2$치명률),2),
    "%로 일반 교통사고(",
    round(mean(df3$치명률),2),
    "%)보다", 
    round((round(mean(df2$치명률),2) / round(mean(df3$치명률),2)),2),
    "배 높은 것으로 나타났다.\"")

# 그래프 그리기
install.packages("ggplot2")
library(ggplot2)  #그래프를 그리고, 그래프 스타일  연결,
ggplot(mapping =aes(x=년도, y=사고, fill=구분), data=df) +
  geom_bar(stat="identity", position=position_dodge()) +
  ggtitle('년도별 사고건수')+
  theme(plot.title = element_text(hjust = 0.5,size=20,face='bold'))













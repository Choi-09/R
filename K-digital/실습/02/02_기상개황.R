
# 1. 파일 읽어오기
setdw("C:\RWork\실습\02")
data <- read.csv("02_기상개황.csv",header = T,  fileEncoding = 'euc-kr',  sep = ',')
head(data)


# 2. 데이터프레임에 데이터 넣기
df <- data.frame(data)
head(df)


# 3. 필요한 열 추출
df <- df[c('월별.1.', '평균기온....', '평균상대습도....')]
df


# 4. 열 명 수정
names(df) <- c('월별', '평균기온', '평균상대습도')
df


# 5. 원하는 수치 만들기
df$불쾌지수 <- 0.81 * df$평균기온 + 0.01 * df$평균상대습도*(0.99 * df$평균기온 - 14.3) + 46.3
df$불쾌지수 <- round(df$불쾌지수,2)
df


# 6. 범주 나누기
df$불쾌지수단계 <- ifelse((df$불쾌지수>=80),"매우높음", 
                    ifelse((df$불쾌지수>=75 & df$불쾌지수<80),"높음",
                           ifelse((df$불쾌지수 >= 68 & df$불쾌지수 < 75),"보통", "낮음")))


# 7. 연간자료 제외
df <- df[2:13,]
df  


# 8. 그래프 그리기 
# 월별 불쾌지수 그래프
ggplot(mapping =aes(x=월별, y=불쾌지수, fill=불쾌지수), data=df) +
  geom_bar(stat="identity", position=position_dodge()) +
  ggtitle("월별불쾌지수")+
  theme(plot.title = element_text(hjust = 0.5,size=20,face='bold')) # 그래프넣기                

  
# 불쾌지수 단계별 그래프 
# (1) barplot 
di <- table(df$불쾌지수단계)
class(di)
barplot(di)

# (2) ggplot 
di2 <- as.data.frame(di)
di2
ggplot(mapping =aes(x=Var1, y=Freq, fill=Var1), data=di2) +
  geom_bar(stat="identity", position=position_dodge()) +
  ggtitle("불쾌지수")+
  theme(plot.title = element_text(hjust = 0.5,size=20,face='bold')) # 그래프넣기

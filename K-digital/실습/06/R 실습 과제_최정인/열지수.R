setwd("C:/RWork/실습/06")
data <- read.csv("06_지상관측.csv", fileEncoding = 'euc-kr', header = TRUE)
df <- data.frame(data)
head(df)


# 2. 열지수 구하고 그래프 그리기

# 필요한 열 추출  # 지점명 == c(지역) 하면 누락되는 데이터 있음! %in% 연산자로 사용하자. 
df1 <- df[df$지점명 %in% c('서울','부산', '제주'),] 
df1

# 열 명 변경
names(df1) <- c('지점', '지점명', '일시', '기온', '풍속', '상대습도')
df1

# 열지수 구하기
# • 열지수 = HI = 0.5 * {T + 61.0 + [(T-68.0)*1.2] + (RH*0.094)}
# ◦ T : 기온(°C), RH : 상대습도(%)

df1$열지수 <-  round(0.5 * {df1$기온 + 61.0 + (df1$기온-68.0)*1.2 + (df1$상대습도*0.094)},2)
head(df1)

rownames(df1) <- NULL
df1

names(df1)

# 일자열 기온그래프: 평균 기온을 수평선으로 표시
library(ggplot2)
ggplot(mapping = aes(x=일시, y=기온, fill=지점명), data=df1) +
  geom_bar(stat="identity", position=position_dodge()) +
  ggtitle('기온현황')+
  theme(plot.title = element_text(hjust =0.5,size=20,face='bold'),axis.text.x = element_text(angle = 90))+
  geom_hline(aes(yintercept=mean(df1$기온), colour='red'), data=df1, linetype='dashed', size=0.5)

# 평균기온
mean(df1$기온)

#  일자별 열지수 그래프 : 열지수 5를 수평선으로 표시
ggplot(data=df1, aes(x=일시, y=열지수, group=지점명, col = 지점명)) +
  geom_line()+
  geom_point()+
  ggtitle('열지수 현황')+
  theme(plot.title = element_text(hjust =0.5,size=20,face='bold'),axis.text.x = element_text(angle = 90))+
  geom_hline(yintercept = 5, col = 'red')

# 일자별로 그룹핑하여 열지수가 5이하인 자료를 추출하시오.
library(dplyr) 

tb <- df1[df1$열지수<=5,]
tb
table(tb$일시, tb$지점명)

# 일자별 그룹핑 교수님 ver.
names(df1)
group <- df1 %>%
  group_by(일시) %>%
  summarise(열지수평균 = mean(열지수),  # group_by는 summarise와 같이 쓴다.
            기온평균 = mean(기온))
group

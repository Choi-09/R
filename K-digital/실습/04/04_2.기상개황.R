# 기상개황 자료를 이용하여 월별 불쾌지수를 계산하고 
# 불쾌지수가 높음이상인 월을 구하시오.
# 
# https://kosis.kr/statHtml/statHtml.do?orgId=735&tblId=DT_A1040&vw_cd=MT_ZTITLE&list_id=215_215A_735_73503_A&seqNo=&lang_mode=ko&language=kor&obj_var_id=&itm_id=&conn_path=MT_ZTITLE
# 
# 불쾌지수 공식
# 
# DI = 0.81 * Ta + 0.01 * RH * (0.99 * Ta - 14.3) + 46.3
# DI: 불쾌지수
# Ta: 건구온도(평균기온)
# RH: 상대습도(평균상대습도)
# 불쾌지수 단계
# 
# 매우높음: 80이상
# 높음: 75이상 80미만
# 보통: 68이상 75미만
# 낮음: 68미만

setwd("C:/RWork/실습/04")
data <- read.csv("04_기상개황.csv", fileEncoding = "euc-kr", header = T, )
df <- data.frame(data)
df

# 데이터프레임에서 열 추출하기
df1 <- df[c('월별.1.', '평균기온....','평균상대습도....' )]
df1

# 열 이름 수정
names(df1) <- c('월', '평균기온', '평균상대습도')
df1

# 연간데이터 삭제
df1 <- df1[-1,]
df1

# 월별 불쾌지수 구하기(소숫점두자리)
df1$불쾌지수 <- round((0.81* df1$평균기온 + 0.01*df1$평균상대습도*(0.99*df1$평균기온 -14.3) + 46.3),2)
summary(df1)

# 불쾌정도 구간 나누기
df1$불쾌정도 <- ifelse(df1$불쾌지수 >= 80, "매우높음", 
                   ifelse(df1$불쾌지수 >=75, "높음", 
                          ifelse(df1$불쾌지수 >=68, "보통", "낮음")))
df1

# 불쾌정도 높음 이상인 월 구하기
a <- df1[df1$불쾌지수>=75,]
a

# 월별 불쾌지수 구간 그래프 그리기
library(ggplot2)
install.packages("ggthemes")
library(ggthemes)
install.packages("gridExtra")
library(gridExtra)

#ggplot(mapping =aes(x=월, y=불쾌지수, fill=불쾌정도), data=df1) +
#  scale_y_continuous(name = "불쾌지수", limits=c(0, 85), breaks=seq(0,100,by=10))+
#  scale_x_discrete(limits=c(df1$월)) +
#  geom_bar(stat="identity", position=position_dodge()) +
#  theme_stata()+
#  ggtitle("월별 불쾌지수 구간")+
#  theme(plot.title = element_text(hjust = 0.5,size=20,face='bold')) # 그래프넣기#  theme(axis.text.x=element_text( angle=45))

ggplot(data = df1,aes(x =월, y=불쾌지수, group = '불쾌지수')) +
  geom_line( size = 1, color = 'dark green' )+
  scale_x_discrete(limits = df1$월)
  
        
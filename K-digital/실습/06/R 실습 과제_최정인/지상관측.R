setwd("C:/RWork/실습/06")
data <- read.csv("06_지상관측.csv",  header = TRUE, fileEncoding = 'euc-kr')
df <- data.frame(data)
head(df)

# 1. 부산 겨울철 체감온도 구하고 그래프 그리기

# 부산 데이터 추출
bs <- df[df$지점명 == '부산',]
bs

# 열 명바꾸기 
names(bs) <- c('지점', '지점명', '일시', '기온', '풍속', '상대습도')
head(bs) 

# • 체감온도 = 13.12 + 0.6215*T –11.37*V*0.16 + 0.3965*V*0.16*T
# ◦T : 기온(°C), V : 풍속(km/h)

# 체감온도 구하기(풍속m/s > 풍속 km/h)
bs$체감온도 <- round(13.12 + 0.6215*bs$기온 - 11.37*(bs$풍속*3.6)*0.16 + 0.3965*(bs$풍속*3.6)*0.16*bs$기온,2)
bs$체감온도  # 체감온도: 풍속km/h
head(bs)

# 겨울철 체감온도 
sensory_temp <- bs[bs$기온 <= 10 & bs$풍속 >=1.3,]
sensory_temp

library("ggplot2")

ggplot(mapping = aes(x=일시, y=체감온도, fill=체감온도), data=sensory_temp) +
  geom_bar(stat="identity", position=position_dodge()) +
  ggtitle('부산지역 겨울철 체감온도')+
  xlab("") + ylab("")+
  theme(plot.title = element_text(hjust =0.5,size=20,face='bold'),axis.text.x = element_text(angle = 90))

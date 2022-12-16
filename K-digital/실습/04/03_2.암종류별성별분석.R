install.packages("dplyr")
#암종류별 성별 분석
library(dplyr)


#데이터 불러오기(암발생자수)
getwd()
setwd("C:/RWork/실습/03.치매환자현황분석")
data <- read.csv("03_암발생자수_.csv", fileEncoding = "euc-kr", header = T, )
df <- data.frame(data)
df


# 열명 변경
# "암종별", "성별", "연령별", "발생자수", "조발생률"
names(df) 
names(df) <- c('암종별', '성별', '연령별', '발생자수', '조발생률')


# 데이터셋 조회

# 1) 특정 변수 조회
df$암종별
mode(df$암종별)
class(df$암종별)

# 2) 특정 열명을 사용하여 조회
  # 사용가능하지만 벡터타입으로 변환해서 데이터수정해야하는 번거로움이 있으므로
  # 되도록이면 벡터타입을 바로 불러오는 $를 사용하자
t2 <- df['암종별']
mode(df['암종별'])
class(df['암종별'])
t2


# 3) 특정 행 조회 :1행 조회
df[1,] 


# 4)특정행 제거 : 1행제거
df <- df[-1,]

df
# 5) 특정행 열 조회
df[1:3,c('암종별', '발생자수')] 


# 열 데이터 타입 확인
str(df)


# 값 변경 : - => 0
df$발생자수 <- ifelse(df$발생자수 == "-", 0, df$발생자수)
df$발생자수 <-  as.numeric(df$발생자수)

df$조발생률 <- ifelse(df$조발생률 == "-", 0, df$조발생률)
df$조발생률 <- as.numeric(df$조발생률)


# 암종류 확인
unique(df2$'암종별')

# 모든암 제거하고 연령별이 계인 데이터 
class(df)
filter
df2 <- df %>%
  filter(암종별 != "모든 암(C00-C96)") %>% 
  filter(연령별 == "계")

df2   

unique(df2$'암종별') 

df21 <- df2 %>% 
  filter(성별 == "계")
df21


df22 <- df2 %>%
  filter(성별 != "계")
df22



# 특정 열가져오기
df21 <- df21[, c('암종별', '발생자수')]
df21

df22 <- df22[, c('암종별', '성별', '발생자수')]
df22


# 그래프 
install.packages("ggplot2")
library(ggplot2)
 
#df21 그래프

ggplot(mapping =aes(x=암종별, y=발생자수, fill=발생자수), data=df21) +
  geom_bar(stat="identity", position=position_dodge()) +
  ggtitle('암종별 발생자수 분석')+
  theme(plot.title = element_text(hjust = 2000,size=20,face='bold')) + coord_flip()

qplot(data = df21, x=암종별, fill = 발생자수, geom="bar")

pie(df21)

#df22 그래프
ggplot(mapping =aes(x=암종별, y=발생자수, fill=성별), data=df22) +
  geom_bar(stat="identity", position=position_dodge()) +
  ggtitle('성별  분석')+
  theme(plot.title = element_text(hjust =2000,size=20,face='bold'))+coord_flip()

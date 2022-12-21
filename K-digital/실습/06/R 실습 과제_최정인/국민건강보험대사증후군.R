setwd("C:\\RWork\\실습\\06")
data <- read.csv("06_국민건강보험공단500.csv")
df <- data.frame(data)

head(df)
names(df)
# 국민건강보험 대사증후군 판별 지도학습모델 만들고 정확도 측정 

# 필요한 열 추출
df2 <- df[c('시도코드', '성별코드', '수축기.혈압', '이완기.혈압', '식전혈당.공복혈당.', '트리글리세라이드', 'HDL.콜레스테롤', '허리둘레')]
head(df2)

# 열 명 변경
names(df2)<- c('시도코드', '성별코드', '수축기혈압', '이완기혈압', '공복혈당', '트리글리세라이드', 'HDL콜레스테롤', '허리둘레')
names(df2)

# na 결측치 값 삭제
df2 <- na.omit(df2)
sum(is.na(df2))
df2

# 대사증후군 판별 데이터 추출 
df2$높은혈압 <- ifelse((df2$수축기혈압>= 130 | df2$이완기혈압 >=85), 1,0)
df2$높은혈압

df2$높은혈당 <- ifelse((df2$공복혈당 >=100), 1,0)
df2$높은혈당

df2$높은중성지방 <- ifelse((df2$트리글리세라이드 >= 150),1,0)

head(df2$성별코드)
df2$낮은HDL콜레스테롤 <- ifelse(((df2$성별코드 == 1 & df2$HDL콜레스테롤 < 40) | (df2$성별코드 == 2 & df2$HDL콜레스테롤 < 50)),1,0)
df2$낮은HDL콜레스테롤

df2$복부비만 <- ifelse(((df2$성별코드 == 1 & df2$허리둘레 >= 90) | (df2$성별코드 == 2 & df2$허리둘레 >= 85)),1,0)

# 대사증후군 판별 구간 나누기
head(df2)
df2$총점 <- df2$높은혈압 + df2$높은혈당 + df2$높은중성지방 + df2$낮은HDL콜레스테롤 + df2$복부비만
str(df2)
summary(df2)
names(df2)


# 대사증후군 판별1.(구간 나눠서)
df2$결과 <- ifelse(df2$총점  < 1 , "정상", 
                 ifelse(df2$총점 <= 2, "주의군", "위험군"))
df2$결과 <- as.factor(df2$결과)


# 대사증후군 판별2.(지도학습모델)

meta <- df2[,c('성별코드','높은혈압', '높은혈당', '높은중성지방', '낮은HDL콜레스테롤', '복부비만', '결과')]
meta
str(meta)

x <- sample(1:nrow(meta), 0.7 * nrow(meta))
train <- df2[x, ]
test <- df2[-x,]

library(ggplot2)
library(party)
str(meta)

result <- ctree(결과 ~ 성별코드 + 높은혈압 +높은혈당 + 높은중성지방+ 낮은HDL콜레스테롤+ 복부비만, data = train)
result

pred <- predict(result, test)
pred

t <- table(test$결과, pred)
t

acc <- (t[1,1] + t[2,2] + t[3,3])/sum(t)
acc

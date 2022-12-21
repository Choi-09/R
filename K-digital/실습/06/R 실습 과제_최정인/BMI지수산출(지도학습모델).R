setwd("C:\\RWork\\실습\\06")
data <- read.csv("06_국민건강보험공단500.csv")
df <- data.frame(data)

head(df)
names(df)

# BMI지수 계산에 필요한 열 추출
df1 <- df[c('성별코드', '연령대.코드.5세단위.','신장.5Cm단위.', '체중.5Kg.단위.', '허리둘레', '음주여부')]
names(df1) <- c( '성별','연령대', '신장', '체중','허리둘레', '음주여부')

head(df1)
str(df1)

# 신장 단위 변환 (cm > m)
df1$신장 <- df1$신장/100

# BMI = 몸무게(kg) / 키(m)^2
df1$BMI지수 <- df1$체중 / df1$신장^2

str(df1)
#==============BMI 예측=================================

# BMI 예측 모델
x <- sample(1:nrow(df1), 0.7 * nrow(df1))

train <- df1[x, ]
test <- df1[-x,]

nrow(train)
nrow(test)
nrow(df1)

model <- lm(formula = BMI지수 ~ 신장 +체중 , data=train)
model

pred <- predict(model, test)

RMSE <-  sqrt(mean((test$BMI지수 - pred)^2))
RMSE

#==============비만도 예측=================================

# 비만도 판별 구간 나누기
df1$결과 <- ifelse(df1$BMI지수  < 20 , "저체중", 
                 ifelse(df1$BMI지수 <= 24, "정상", 
                        ifelse(df1$BMI지수 <=29, "과제충", "비만")))
df1$결과 <- as.factor(df1$결과)

head(df1$결과)
str(df1)

# 비만도 예측 모델 
x <- sample(1:nrow(df1), 0.7 * nrow(df1))

train <- df1[x,]
test <- df1[-x,]



library(party)

result <- ctree(결과 ~ 성별 + 연령대 +신장 + 체중+ BMI지수, data = train)

pred <- predict(result, test)

t <- table(test$결과, pred)
t

acc <- (t[1,1] + t[2,2] + t[3,3] + t[4,4])/sum(t)
acc


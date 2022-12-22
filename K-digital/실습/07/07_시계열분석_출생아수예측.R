setwd("C:/RWork/실습/08")
df <- read.csv("07_출생아수.csv", 
               header = T, 
               stringsAsFactors = F, 
               fileEncoding = 'euc-kr') 
str(df)

names(df) <- c('시점', '출생아수')
df
plot(df$시점,  df$출생아수)

library(dplyr)


train <- df %>% filter(시점 < 2011)
train
length(train)

test <- df %>% filter(시점 >=2011 & 시점 <= 2015)
length(test)

temp <- train$출생아수

t_ts <- ts(temp, frequency = 1, start = c(2000))
t_ts


library(forecast)

arima <- auto.arima(t_ts) # 몇 번 차분을 하면 주기성을  갖는지 알려줌! 
arima


model <- arima(t_ts, order=c(0,1,0))
model

tsdiag(model)

Box.test(model$residuals, lag=1, type="Ljung")


fore <- forecast(model, h=5)
fore

plot(fore)

pred = as.vector(fore$mean)
test$출생아수

result <- data.frame(test = test$출생아수, pred=pred)
result

plot(result$test, type="o", col="red") # 실제 데이터 
par(new=T)
plot(result$pred, type="o", col="blue")  # 예측 그래프

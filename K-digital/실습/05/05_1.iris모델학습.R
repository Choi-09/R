
#R 내장 데이터 가져오기
data(iris)
iris

#iris 데이터 확인
str(iris)

#iris : 꽃받침, 꽃잎 데이터 추출
iris1 <- iris[, -5]
iris1

#기술통계량
summary(iris1) 

#상관계수** : +, - 관계 가능,  절댓값으로 상관관계 판별. |0.7| 이상이면 높은 상관관계. 
cor(iris1, method="pearson")

#색의 농도로 상관계수: 색깔이 진할수록 높은 상관관계. 
install.packages("corrgram")
library(corrgram)

corrgram(iris1, upper.panel = panel.conf)

#상관계수 차트 : 계수값도 같이 나온다. 
install.packages("PerformanceAnalytics")
library(PerformanceAnalytics)

chart.Correlation(iris1)

#학습(train)데이터와 테스트(test)데이터 분리
#분리시키는 이유: 맞는지 틀린지 보려고 
x <- sample(1:nrow(iris1), 0.7 * nrow(iris1)) # python: sklearn
x      # 품종별 골고루 샘플 추출하기 위해서 sample 사용
# 보통 70%를 훈련데이터로, 30%를 테스트 데이터로 분리(80:20 하는 경우도 있음)

train <- iris[x, ]
test <- iris[-x,]

nrow(train)
nrow(test)

#회귀모델 : 꽃받침 길이 예측 
names(iris1)

#학습
# lm() :선형회귀선 구하는 공식 
# Sepal.Length 예측 ~ feature: Sepal.Width + Peral.Length + Petal.Width 
# R에서는 모델에서 타겟과 feature을 나누어 바로 학습시킨다.
# 파이썬에서는 미리 나눈다. 
model1 <- lm(formula = Sepal.Length ~ Sepal.Width + Petal.Length + Petal.Width, data=train)
model1  #y = 0.6002x1 + 0.7313x2 -0.6062x3 + 1.9875
 
model2 <- lm(formula = Sepal.Length ~ Petal.Length + Petal.Width, data=train)
model2

model3 <- lm(formula = Sepal.Length ~ Petal.Length , data=train)
model3

model4 <- lm(formula = Sepal.Length ~ Sepal.Width + Petal.Length , data=train)
model4


#예측
pred1 <- predict(model1, test)
pred1

pred2 <- predict(model2, test)
pred2

pred3 <- predict(model3, test)
pred3

pred4 <- predict(model4, test)
pred4

#평가
#RMSE : sqrt((실제 - 예측)^2의 평균) 
# 유클리디안거리계산. 값이 클수록 거리가 멀다. = 선형회귀선과의 거리가 멀다 = 오차가 크다  
sqrt(mean((test$Sepal.Length - pred)^2))

RMSE1 <-  sqrt(mean((test$Sepal.Length - pred1)^2))
cat("예측1:", RMSE1)

RMSE2 <-  sqrt(mean((test$Sepal.Length - pred2)^2))
cat("예측2:", RMSE2)

RMSE3 <-  sqrt(mean((test$Sepal.Length - pred3)^2))
cat("예측3:", RMSE3)

RMSE4 <-  sqrt(mean((test$Sepal.Length - pred4)^2))
cat("예측4:", RMSE4)

#분류모델 
library(ggplot2)
ggplot(iris, aes(Sepal.Length, Sepal.Width))  + 
  geom_point(aes(colour = Species))

ggplot(iris, aes(Petal.Length , Petal.Width))  + 
  geom_point(aes(colour = Species))

ggplot(iris, aes(Sepal.Length , Petal.Width))  + 
  geom_point(aes(colour = Species))

ggplot(iris, aes(Sepal.Width , Petal.Length))  + 
  geom_point(aes(colour = Species))

ggplot(iris, aes(Sepal.Width , Petal.Width))  + 
  geom_point(aes(colour = Species))


#학습데이터와 테스트데이터 나누기
x <- sample(1:nrow(iris), 0.7 * nrow(iris)) 
x


#모델 학습
train <- iris[x, ]
train
test <- iris[-x,]
test


#트리 모델 
install.packages("party")
library(party)
names(iris)
# 지도학습에서는 Y값이 타겟. 
#model1: Sepal, Petal 
model1 <- ctree(Species ~ Sepal.Length + Sepal.Width + 
                 Petal.Length + Petal.Width,
               data = train)
plot(model1)

# model2: Sepal 
model2 <- ctree(Species ~ Sepal.Length + Sepal.Width ,
                data = train)

# model3: Length
model3 <- ctree(Species ~ Sepal.Length + 
                  Petal.Length,
                data = train)

# model4: Width
model4 <- ctree(Species ~  Sepal.Width + 
                  Petal.Width,
                data = train)

#예측
#model1: Sepal, Petal 
pred1 <- predict(model1, test) 
pred1

# model2: Sepal 
pred2 <- predict(model2, test) 
pred2

# model3: Length
pred3 <- predict(model3, test) 
pred3

# model4: Width
pred4 <- predict(model4, test) 
pred4

#혼돈행렬
t1 <- table(test$Species, pred1)
t1

t2 <- table(test$Species, pred2)
t2

t3 <- table(test$Species, pred3)
t3

t4 <- table(test$Species, pred4)
t4

sum(t1)
sum(t2)
sum(t3)
sum(t4)


# 성능지표 
accuracy1 <- (t1[1,1] + t1[2,2] + t1[3,3]) / sum(t1)
cat("성능1:", accuracy1)

accuracy2 <- (t2[1,1] + t2[2,2] + t2[3,3]) / sum(t2)
cat("성능2:", accuracy2)

accuracy3 <- (t3[1,1] + t3[2,2] + t3[3,3]) / sum(t3)
cat("성능3:", accuracy3)

accuracy4 <- (t4[1,1] + t4[2,2] + t4[3,3]) / sum(t4)
cat("성능4:", accuracy4)


#iris data 저장
 

#타이타닉 데이터
#https://www.kaggle.com/c/titanic/overview

#데이터불러오기
setwd("C:/RWork/실습/05")
df <- read.csv("05_titanic.csv", 
                  header = T, 
                  stringsAsFactors = F, 
                  fileEncoding = 'euc-kr') 
head(df)

#데이터구조
# PassengerID	승객을 구별하는 고유 ID number	Int
# Survived	승객의 생존 여부를 나타내며 생존은 1, 사망은 0 입니다.	Factor
# Pclass	선실의 등급으로서 1등급(1)부터 3등급(3)까지 3개 범주입니다.	Ord.Factor
# Name	승객의 이름	Factor
# Sex	승객의 성별	Factor
# Age	승객의 나이	Numeric
# SibSp	각 승객과 동반하는 형제 또는 배우자의 수를 설명하는 변수이며 0부터 8까지 존재합니다.	Integer
# Parch	각 승객과 동반하는 부모님 또는 자녀의 수를 설명하는 변수이며 0부터 9까지 존재합니다.	Integer
# Ticket	승객이 탑승한 티켓에 대한 문자열 변수	Factor
# Fare	승객이 지금까지 여행하면서 지불한 금액에 대한 변수	Numeric
# Cabin	각 승객의 선실을 구분하는 변수이며 범주와 결측치가 너무 많습니다.	Factor
# Embarked	승선항, 출항지를 나타내며 C, Q, S 3개 범주이다.	Factor

# 1. 필요한 데이터인지 판별
# 1-1) Survived : 카테고리화 
df$Survived <- as.factor(df$Survived)
ggplot(data =df, aes(x = df$Survived, fill = df$Sex)) +geom_bar()

# 1-2) Pclass: 카테고리화
df$Pclass <- as.factor(df$Pclass)
ggplot(data =df, aes(x = df$Survived, fill = df$Pclass)) +geom_bar()

# 1-3) Sex: 카테고리화
ggplot(data =df, aes(x = df$Survived, fill = df$Sex)) +geom_bar()

# 1-4) Age: 카테고리화 => 결측치 데이터부터 처리 
# 결측치 확인
summary(df)

# 결측치 처리
# df <- na.omit(df)
# df

# 1-4-1)평균값으로 대체
df$Age <- ifelse(is.na(df$Age), mean(df$Age, na.rm=T), df$Age)
summary(df)

# 성별에 따른 생존여부
table(df$Survived, df$Sex)


library(ggplot2)


class(df$Survived)
mode(df$Survived)
 

#Pclass	선실의 등급에 따른 생존여부
table(df$Survived, df$Pclass) 


#분류모델: 
titanic <- df[,c('Pclass', 'Sex', 'Age', 'SibSp', 'Parch', 'Survived')]
titanic


#수치데이터로 변환
titanic$Sex <- ifelse(titanic$Sex == 'male', 1, 2) 


# 학습, 테스트 데이터 나누기
x <- sample(1:nrow(titanic), 0.7 * nrow(titanic)) # python: sklearn
x      
train <- titanic[x, ]
test <- titanic[-x,]


# 학습: 트리모델
result <- ctree(Survived ~ Sex + Pclass + Age, data = titanic)
plot(result)


# 예측
pred <- predict(result, test)
pred

 
#혼돈행렬: 
t <- table(test$Survived, pred)
t
#accuracy
acc <- (t[1,1] + t[2,2])/sum(t)
acc

# 주사위 1개 던지기 

#랜덤한 값 생성 (값들이 unique)
runif(10000)

# 던질때마다 runif 값을 지정해줄 수 없으니 roll로 값을 고정한다.
roll <- 100

# 주사위의 면도 변수에 할당 
n <- 6

# 6을 곱해 1의자리수를 만들어내고, 올림하기.
# ceiling() : 올림
dice <- ceiling(runif(roll)*n)
dice

# table() : 분류하기
b <- table(dice)

barplot(b)

b



# 주사위 2개 던지기

roll <- 100
dice <- ceiling(runif(roll)*6) + ceiling(runif(roll)*6)
b2 <- table(dice)
b2

barplot(b2)

# => 결과: 7이 나올 확률이 높음. 실제로 경우의 수가 많다.
# (1,6), (6,1), (2,5), (5,2), (3,4), (4,3)

b2[1]*6
b2[6]











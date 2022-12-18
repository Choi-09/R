# 평균이 80, sd = 10 인 정규분포 그래프 그리기 
x <- seq(40, 120, length = 300)
x
y <- dnorm(x,mean=80, sd = 10)
y
plot(x,y, type = "l", col = "red")


# 65~75사이의 범위가 어디인지?
x2 <- seq(65,75,length = 200)
y2 <- dnorm(x2, mean=80, sd=10)polygon(c(65,x2,75), c(0,y2,0), col = "gray")

pnorm  # polygon의 넓이
qnorm  # polygon의 x 범위
rnorm  # 임의의 랜덤 넘버 생성

pnorm(75, mean=80, sd=10) - pnorm(65,mean=80,sd=10)


# 92이상 
pnorm(92,mean=80, sd=10, lower.tail = FALSE)  # lower.tail: 왼쪽범위
1 - pnorm(92,mean=80, sd=10)

# 68 미만
pnorm(68, mean=80, sd = 10)

# 하위 30%인 지점
qnorm(0.3, mean=80, sd=10)

# 하위 80%인 지점
qnorm(0.8, mean=80, sd=10)

# 중간 60% 지점
qnorm(0.8, mean=80, sd = 10)
qnorm(0.2, mean=80, sd = 10)



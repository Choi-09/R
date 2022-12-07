# 데이터 정리 라이브러리 설치
install.packages("tidyr")
install.packages("dplyr")
library(tidyr)
library(dplyr)

# 멤버 데이터변수 설정
member <- data.frame(family = c(1,2,3), namef = c("a","b", "c"),
                     agef = c(30,40,23), namem = c("d", "e", "F"),
                     agem = c(44,35,25))
member

# 변수를 추가하며 데이터 가공  
a <-gather(member, key, value, namef: agem)  # key, value로 나눈다. namef:agem >> namef부터 agem까지의 데이터를.
a
b <- separate(a, key, c("variable", "type"), -1)  # key를 "variable"과 "type"으로 나눈다. 기준: key의 -1번째 
b
new <- spread(b, variable, value)  
new

# 파이프라인으로 데이터 가공 

new2 <- member %>%
        gather(key, value, namef:agem) %>%
        separate(key, c("variable", "type"), -1) %>%
        spread(variable, value)

new2

filter(new, type=="f")

# 데이터 정리 라이브러리 설치
install.packages("tidyr")    # tidyr: 자료를 조건에 따라 배열을 바꾸는 함수를 제공
install.packages("dplyr")    # dplyr: 데이터 처리 패키지. %>% 파이프라인으로 data.frame에서 자료를 조건에 따라 선택하고, 배열하고, 결합하고, 요약하는데 편리한 함수.
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
        gather(key, value, namef:agem) %>%       # namef 부터 agem까지의 member데이터를 key와 value로 모은다. gather: 여러 컬럼을 하나의 컬럼으로 모은다. 
        separate(key, c("variable", "type"), -1) %>%    # key를 다시 "variable"과 "type"으로 나누는데 뒤에서 첫번째를 기준으로 나눈다.(-1)  separate: 
        spread(variable, value)     # gather의 반대 방향으로, 세로형 데이터를 가로형으로 변형

new2

filter(new, type=="f")

n <- 3
m <- "3"
n+m # 오류! 

is.character(n)   # False
is.character(m)   # True

as.character(n)   # 형변환: as.
n
m
n <- as.character(n)
n
# ==============================================
# 데이터에 string이 포함되면 데이터 전체가 string 타입으로 변한다. 
t<-c(1:5)
t

t2 <- c(1:5,'a')
t2

t3 <- c(1:4, TRUE, FALSE)
class(t3)
t3

t4 <-  c(1:4, TRUE, FALSE, "A")
t4

# ==============================================
# string 데이터 이어붙이기: paste()

df1 <- data.frame(n=c(1:4,"A"), letters = c("a", "b", "23", "1", "4"))
str(df1)
df1

hello <- paste(1,2)  # int 타입도 paste하면 string이 된다. 
hello
class(hello)

hi <- paste("Hi", "Jack")
hi
paste("jac", "k", sep="")
paste(hi, "what's up?", sep = ', ')

c('1-1','1-2', ...)
class = paste("1", 1:10, sep = "-")
class

a <- paste("The value of 'pi' is", pi, "endless!!!")

noquote(a)  # string 타입의 " "따옴표 없애기 
print(a,quote=FALSE)


cars <- rownames(mtcars)
colnames(mtcars)
names(mtcars)

nchar(cars)
cars[which(nchar(cars)==max(nchar(cars)))]  # cars에서 nchar가 가장 긴 차의 위치를 통해서 해당 car호출

# =============================================
# 특정한 값을 가진 데이터를 불러오기
# grep(, value = TRUE)
grep("v", cars, value=TRUE)  

grep("[vV]", cars, value=TRUE)  

grep("TOYOTA", toupper(cars), value=TRUE)  # 대소문자 통일하기 

install.packages("stringr")  # stringr: 문자열 데이터를 가공하기 위해 자주 사용되는 패키지
library(stringr)

cars
str_count(cars,"t") # cars의 데이터들이 t를 몇개나 갖고있는지 

sum(str_count(toupper(cars),"TOYOTA"))

# =============================================
# 캐릭터별 split 

strsplit("adjcfkdjskckljzklc", split="k")

a<-strsplit("how are you?", split="")
paste(a[[1]], collapse="")  # collapse: 공백 없애기       

reversed <- a[[1]][12:1]  # 반드시 string a를 리스트로 담아준 후 reverse하고자 하는 범위 적기! 
reversed
paste(reversed, collapse="")

rf <- function(string){
a <- strsplit(string, split="")
reversed <- a[[1]][nchar(string):1]
paste(reversed, collapse="")
}

rf(rf("how are you?, jack, Emily"))


# ============================================
# 단어별 split
a <- strsplit("how are you?", split=" ")
a
reversed <- a[[1]][3:1]

reversed

paste(reversed, collapse = " ")

str_length <- length(a[[1]])
str_length

rev_word <- function(string){
  a <- strsplit(string, split=" ")
  str_length <- length(a[[1]])   # str_length로 문장 전체(a) 길이  정의 
  reversed <- a[[1]][str_length:1]
  paste(reversed, collapse = " ")
}

rev_word("how are you? i am fine thank you")

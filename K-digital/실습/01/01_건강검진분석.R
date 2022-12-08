# 해결문제 
# BMI는 몸무게와 키를 이용하여 체지방율을 측정하는 지수이다. 
# 자신의 몸무게와 키를 각각 변수 weight와 height에 저장하고 BMI지수를 계산해 본다. 
# 단, 키는 cm로 입력 받아서 처리한다.
# 
# BMI = 체중(kg) / (키(m) x키(m))

  
 
# 키와 몸무게 scala입력
height <- scan()
weight <- scan()



# 몸무게 수치 변환
  


# BMI 계산
BMI <- weight / (height / 100) **2
 

# 키와 몸무게 vector입력
print("키와 몸무게 입력")
data <- scan()
height <- data[1]
weight <- data[2]
BMI <- weight / (height / 100) **2


#문자열 입력
data <- readline()
data 

# stringr 패키지 설치
install.packages("stringr")
library(stringr) 

# 문자열 분리
data_sp <- str_split(data, " ") 
data_sp


# 자료형 확인
mode(data_sp)


# 벡터로 형변환
data_sp <- unlist(data_sp)  # list 깨기 
data_sp
mode(data_sp)
 

# 벡터 확인
is.vector(data_sp) 


# 숫자벡터로 변경
data_sp = as.numeric(data_sp)
data_sp


# 데이터프레임 입력
df <- data.frame()
mode(df)
class(df)

df <- edit(df)  # var적도 창닫으면 자동저장
df              


# 데이터프레임 열명 변경
names(df) <- c("키", "몸무게")  #c : 벡터 생성함수
df                              # names: name 수정 

df$BMI <- df$몸무게 / ((df$키)/100)**2  #$: python의 []. df['BMI'] = df['몸무게'] / ((df['키'])/100)**2
df

# 해결문제 
# 국민건강보험공단 자료를 이용하여 BMI와 비만도를 구하시오.
getwd()
data <- read.csv(file = "C:/RWork/실습/01.국민건강보험데이터분석/01/01_국민건강보험공단500.csv", 
                 sep = ",", 
                 header = TRUE, 
                 fileEncoding = "euc-kr")
head(data)

# 비만도 
df <- data.frame(data)
head(df)

df$BMI <- round((df$체중 / ((df$신장)/100)**2),2)
df


# 저체중	20 미만
df$비만도 <- ifelse(df$BMI <20, "저체중",
                 ifelse(df$BMI<25, "정상",
                        ifelse(df$BMI <29, "과체중", "비만"
                        )))
df

# 정상	20 - 24
# 과체중	25 - 29
# 비만	30 이상
 
# 빈도 테이블****  (python: groupby)
table(df$성별)
table = table(df$성별, df$비만도)
write.csv(table, "성별_비만도.csv", fileEncoding = "euc-kr", row.names =T, quote = F) 
df
# 빈도 테이블 저장
setwd("C:/RWork/실습/01.국민건강보험데이터분석/01") 
write.csv(df, "비만도.csv",fileEncoding = "euc-kr", row.names = T, quote = F)


# 해결문제
# 국민건강보험 관리공단의 건강검진 자료를 이용하여 대사증후군을 판별하시오.
data <- read.csv(file = "C:/RWork/실습/01.국민건강보험데이터분석/01/국민건강보험공단_건강검진정보_20211229.csv", 
                 sep = ",", 
                 header = TRUE, 
                 fileEncoding = "euc-kr")
head(data)

# 높은 혈압(130/85mmHg 이상)
df검진정보 <- data.frame(data)
df검진정보

df검진정보$높은혈압 <- ifelse((df검진정보$수축기.혈압 >= 130) | (df검진정보$이완기.혈압 >=80), 1, 0)
df검진정보

# 높은 혈당(공복 혈당 100mg/dL 이상)
df검진정보$높은혈당 <- ifelse(df검진정보$식전혈당.공복혈당. >= 100,  1, 0)
df검진정보

# 높은 중성지방(트리글리세라이드 150mg/dL 이상)
df검진정보$높은중성지방 <- ifelse(df검진정보$트리글리세라이드 >=150,  1, 0)
df검진정보

# 낮은 HDL 콜레스테롤 수치(남성은 40mg/dL 미만, 여성은 50mg/dL 미만)
df검진정보$낮은HDL콜레스테롤 <- ((df검진정보$성별코드==1)&(df검진정보$HDL.콜레스테롤 <40)|(df검진정보$성별코드==2)&(df검진정보$HDL.콜레스테롤 <50))
df검진정보

# 복부 비만(남성 90cm 이상, 여성 85cm 이상)
df검진정보$복부비만 <- ((df검진정보$성별코드==1)&(df검진정보$허리둘레 >=90)|(df검진정보$성별코드==2)&(df검진정보$허리둘레 >=85))
df검진정보

# 판별
df대사증후군판별 = data.frame(df검진정보$성별코드, df검진정보$높은혈압, df검진정보$높은혈당, df검진정보$높은중성지방, df검진정보$낮은HDL콜레스테롤, df검진정보$복부비만) 
df대사증후군판별

df대사증후군판별=na.omit(df대사증후군판별)

df대사증후군판별

names(df대사증후군판별) <- c("성별코드", "혈압", "혈당", "중성지방", "콜레스테롤", "복부비만")
df대사증후군판별$콜레스테롤 <- ifelse(df대사증후군판별$콜레스테롤, 1, 0)
df대사증후군판별$복부비만 <- ifelse(df대사증후군판별$복부비만, 1, 0)

# 0 : 정상, 1~2 : 주의군, 3~5 : 위험군
df대사증후군판별$점수 <- df대사증후군판별$혈압 + 
                         df대사증후군판별$혈당 + 
                         df대사증후군판별$중성지방 + 
                         df대사증후군판별$콜레스테롤 + 
                         df대사증후군판별$복부비만

head(df대사증후군판별)

df대사증후군판별$결과 <- ifelse(df대사증후군판별$점수  < 1 , "정상", 
                       ifelse(df대사증후군판별$점수 <= 2, "주의군", "위험군"))

df대사증후군판별$성별 <- ifelse(df대사증후군판별$성별코드 == 1, "남", "여")

table(df대사증후군판별$성별, df대사증후군판별$결과)

# 파일 읽어오기
# (1) 파일 선택. header, encoding 필수!
data <- read.csv(file.choose(), header = T, fileEncoding = 'euc-kr')

# head() : data의 처음 6번째 데이터
head(data)

# tail() : data의 끝 6번째 데이터
tail(data)

# str() : data의 구조조
str(data)

# max() : data의 열에서 가장 높은 값 
max(data$가격)

# min() : data의 열에서 가장 낮은 값 

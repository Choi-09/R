# R

## 1. R 정의 및 활용
+ R은 통계 계산과 그래픽을 위한 프로그래밍 언어이자 소프트웨어 환경이다. 
+ Saas, Python도 통계에 많이 쓰이지만 Saas는 비싸기 때문에 큰기업에서 사용.
+ 가능하다면 Python과 R 둘 다 배우는 것이 좋고, R이 좀 더 통계에 특성화 되어있다. 
+ 설치: https://cran.r-project.org/index.html


### IDE: RStudio
+ 다운로드: https://posit.co/download/rstudio-desktop/
+ 가장 많은 사람들이 사용하는 R IDE


### 특징
```
  1. 변수는 변수 명과 값이 우측 Environment 창에 출력되고, 계산 결과는 아래 콘솔창에 출력된다.
  2. 결과 출력을 위해 필요한 함수는 없다. 바로 ctrl + enter 혹은 화면의 'Run' 버튼을 클릭.
  3. 대입 연산자: <- 
      ex) x <- 1  // x에 1을 대입
  4. demo: 각종 시각적 그래프를 plots 창에서 보여준다. => 굉장히 다양한 그래프를 만들 수 있어서 "표현력이 좋다."
``` 


## 2. R Studio 단축키
![Rstudio단축키](https://user-images.githubusercontent.com/51871037/208288593-f5eacdc4-4c2f-4349-92c1-0fbd27886cc8.PNG)


## 3. 파일 입출력
```
  Ⅰ. 파일 입력
      1) 현재 경로 확인
         • getwd()  

      2) 경로 설정
         • setwd("폴더경로")

      3) 파일 읽어오기(.txt, .csv, .xlsx, .xml, .json)
         • read.table("파일명.txt")
         • read.csv("파일명.csv")
         • read_excel("파일명.xlsx")
         • xmlToDataFrame("파일명.xml")
         • fromJSON("파일명.json")
         
         • scan()   # 외부 텍스트 파일 불러와서 벡터 형식으로 저장
         • readline()   # 사용자 입력 데이터 저장
         • readLine()   # 텍스트 파일 한 줄씩 읽어 문자여 벡터로 저장

      4) 파일 읽어올 때 추가 설정
         • header = T /F   # 원시 데이터 1행 (컬럼명) 가져올 지 결정
         • skip = n   # 특정 행을 제외하고 데이터 가져오기
         • nrow = n   # 특정 행 까지 불러오기
         • sep =  ""  //  ","  //  "\t"  //...   # 원시 데이터 구분자
         • fileEncoding = 'euc-kr'   # 한글 인코딩
         • stringsAsFactors = F   # 문자열 컬럼 팩터화
   
  Ⅱ. 파일 출력
      • write.csv("파일명.csv")  # 데이터 프레임을 외부 csv파일로 저장
```


## 4. R 기초
```
  1)  할당
     • 변수명 <- 데이터
  
  2) vector 생성
     • c(value1, value2, ...)
     
  3) 요약 확인
     • summary(data명)
        - min : 최소값
        - 1st Qu : 1사분위 값 (하위 25%)
        - median : 중위값
        - mean : 평균값
        - 3rd Qu. : 3사분위 값 (하위 75%)
        - max : 최대값
     
  4) 객체 리스트 확인 
     • ls()
     
  5) 객체 삭제
     • rm(객체(변수)명)
     
  6) 문자열 합치기
     • paste()
     
  7) 도움말
     • help(객체명)
     • ?객체명
     
  8) 설치된 패키지 확인
     • search()
  
  9) 패키지 설치 및 로딩
     • install.packages("패키지명")
     • library(패키지명)
     
 10) 주석 처리
     • #  
```


## 5. 객체 타입
#### 1) 상수(atomic) 
```
   - 정수형 integer
   - 실수형 double
   - 문자형 character
   - 논리형 logical
   - 복소수형 complex number
```     
#### 2) 벡터(vector)
  - 하나 이상의 원소로 이루어진 자료. 
  - 원소의 데이터 타입이 동일해야 함.
```     
 (1) 벡터 생성
     • c(val1, val2, val2, ...)
     • n : m   # 연속된 정수 벡터 생성(n 부터 m 까지)

 (2) 함수를 이용한 벡터 생성
     • rep(반복할 숫자, 반복횟수)   
       ex) rep(1,5) => [1] 1 1 1 1 1
     • seq(시작, 끝, 간격)   
       ex) seq(0, 10, 2) => [1]  0  2  4  6  8 10
     • seq(시작, 끝, length = n)   
       ex) seq(0, 10, length = 5) => [1]  0.0  2.5  5.0  7.5 10.0
     • numeric / double / integer / character (length = n)   
       ex) character(length = 5) => [1] "" "" "" "" ""

 (3) 벡터의 클래스
     - numeric : 연속형
     - factor : 범주형
     - ordered : 순서가 있는 범주형
```         
#### 3) 행렬(matrix)
  - 2차원 자료의 저장. 
  - 행(row)과 열(column)로 구성됨.
```     
 (1) 행렬 생성
     • x <- matrix(원소범위, nrow = 행길이, ncol = 열길이)   # nrow만 정해도 col은 자동으로 정해진다. 
       ex) matrix(1:10, nrow=2, ncol=5) =>       [,1] [,2] [,3] [,4] [,5]
                                           [1,]    1    3    5    7    9
                                           [2,]    2    4    6    8   10
     • y <- diag(대각선 숫자, 정방행렬크기)   # 대각행렬(정방행렬 중 원소가 i=j인 곳에만 숫자를 채우고, 나머지는 0)
       ex) x <- diag(1,5) =>      [,1] [,2] [,3] [,4] [,5]
                            [1,]    1    0    0    0    0
                            [2,]    0    1    0    0    0
                            [3,]    0    0    1    0    0
                            [4,]    0    0    0    1    0
                            [5,]    0    0    0    0    1
       ex) diag(10), diag(1:10), diag(c(1,3,5,7,9))

    (1-1) 대각원소 추출
           • diag(객체명)
             ex) diag(x) => [1] 1 1 1 1 1

 (2) 행렬/벡터 결합
     - 행 단위 결합
       • rbind( x , y )
     - 열 단위 결합
       • cbind( x , y )

 (3) 행렬 연산
     - 곱
       • x * y
     - 전치행렬
       • t(x)
     - 행렬곱
       • %*% 
     - 역행렬
       • solve(x)
```  
#### 4) 리스트(list)
  - 서로다른 객체들의 원소로 구성되는 객체. 
  - 원소는 상수/벡터/행렬/데이터프레임/함수 등 모든 객체 가능
```
 (1) 리스트 생성 
     • LST <- list(colName1 = val1, colName2 = val2, colName3 = c(1,2,3), ...)
 
 (2) 리스트 원소 접근
     • 리스트명[[인덱스]]
       ex) LST[[1]]
     • 리스트명[['컬럼명']]
       ex) LST[["name"]]
     • 리스트명[[인덱스 n : 인덱스 m]]
 
 (3) 원소 갯수
     • length(리스트명)
 
 (4) 리스트 결합
     - c(list1, list2)    
```
#### 5) 데이터 프레임
  - 테이블 형태의 데이터 객체
  - 컬럼(변수) 길이는 모두 동일
  - 컬럼들은 서로 다른 속성(vector, factor 등)을 가질 수 있음
```
 (1) 데이터프레임 생성
     • data.frame(데이터)
       ex) data.frame(name = name, gender = sex, income = income)
     • as.data.frame()
       : 리스트나 행렬을 데이터프레임으로 변환
 
 (2) 관련 함수
     • head( )
     • tail( )
     • names( )
     • nrow( )   # 행 데이터 차원 출력  
     • ncol( )   # 열 데이터 차원 출력
     • dim( )    # 행, 열 데이터 차원 출력
```     
     

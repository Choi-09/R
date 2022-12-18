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
```
  1) 상수(atomic) 
     - 정수형 integer
     - 실수형 double
     - 문자형 character
     - 논리형 logical
     - 복소수형 complex number
     
  2) 벡터(vector)
     : 하나 이상의 원소로 이루어진 자료. 원소의 데이터 타입이 동일해야 함.
     - c(val1, val2, val2, ...)
     - c(
```

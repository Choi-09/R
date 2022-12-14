## 9장 비정형 텍스트 분석을 위한 koNLP 설치
# 교재 301-303 내용대로 설치가 안됨
# R, rtool 설치시에 아래 버젼으로 설치 - 기존 버젼은 프로그램 제거로 삭제
# 1. R 설치하기(가급적 관리자 권한으로 설치)
# cran.r-project.org/bin/windows/base/R4.1.0

# 2. rtools40 설치하기(c:/Rtools에 설치)
# https://cran.r-project.org/bin/windows/Rtools/index.html >> rtools 4.0으로

##2.0 Rstudio 실행 - 관리자 권한으로 실행
# rJava 먼저 설치해야 함
install.packages("rJava")

# # 2.1 환경 설정
writeLines('PATH="${RTOOLS40_HOME}\\usr\\bin;${PATH}"')
# 
# # 2.2 R Restart
# 
# # 2.3 make 확인
Sys.which("make")

# # 2.4 패키지 설치
install.packages("jsonlite", type = "source")

# 3. java, rJava 설치하기
install.packages("multilinguer")
library(multilinguer)
# warning message가 나오면 다시 실행한다 
install_jdk() #3 Yup을 선택, #install JDK 선택시에 Absolutely를 선택

# 4. 의존성 패키지 설치하기
install.packages(c("hash", "tau", "Sejong", "RSQLite", "devtools", "bit", "rex", "lazyeval", "htmlwidgets", "crosstalk", "promises", "later", "sessioninfo", "xopen", "bit64", "blob", "DBI", "memoise", "plogr", "covr", "DT", "rcmdcheck", "rversions"), type = "binary")


# 5. github 버전 설치하기
install.packages("remotes")

# 6. KoNLP 설치하기(64bit에서만 동작)
remotes::install_github('haven-jeon/KoNLP',force = TRUE, upgrade = "never", INSTALL_opts=c("--no-multiarch"))

# 7. Test
extractNoun('인하대학교 공학대학원 블록체인 전공입니다.')
# 에러 발생

# 라이브러리 불러오기
library(KoNLP)

extractNoun('부산대학교 인공지능 활용 빅데이터 분석 웹서비스 개발자 과정입니다.')
# 정상 실행 됨 - 정상 실행 결과는 다음과 같다.
#[1] "부산대학교" "인공지능"   "활용"       "빅데이터"   "분석"      
#[6] "웹서비스"   "개발자"     "과정"    

# wordcloud 설치
install.packages("wordcloud")
library(wordcloud)

# textMining 설치
install.packages("tm")
library(tm)

name <- c('john', 'jaehee', 'ness', ' juliet', 'james')
sex <- c('m', 'f', 'f', 'f','m')
occup <- c('athelte', 'doctor', 'ceo', 'analyst','teacher')
age <- c(40,35,30,43,29)

name
# 데이터 프레임 만들기
member <- data.frame(name, age, sex, occup)
member

age[1]
name[3]
member[1]   # => member[,1]
member[1,]
member$name  # $: 해당 열 값들을 가져온다
member$sex
member[2,4]

# cell값 수정
member[1,3] <- 'f'
member


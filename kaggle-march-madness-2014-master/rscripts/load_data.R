TRAINING_DATA <- paste('F:/Grad Projects/March Mania/kaggle-march-madness-2014-master/data/features.csv', sep='')

data <- read.table(TRAINING_DATA, sep=',', header=T, as.is=T)
data <- data[complete.cases(data),]
data$gameid <- NULL
data$hteam <- NULL
data$lteam <- NULL
data$seed_diff <- NULL

head(data$target)
names(data)
TEST_DATA <- paste('F:/Grad Projects/March Mania/kaggle-march-madness-2014-master/data/features.csv', sep='')
test.data <- read.table(TEST_DATA, sep=',', header=T, as.is=T)
test.data$gameid <- NULL
test.data$seed_diff <- NULL


logit.predictions <- paste('F:/Grad Projects/March Mania/kaggle-march-madness-2014-master/data/logit_predictions.csv', sep='')
rf.predictions <- paste('F:/Grad Projects/March Mania/kaggle-march-madness-2014-master/data/rf_predictions.csv', sep='')
net.predictions <- paste('F:/Grad Projects/March Mania/kaggle-march-madness-2014-master/data/net_predictions.csv', sep='')
gbm.predictions <- paste('F:/Grad Projects/March Mania/kaggle-march-madness-2014-master/data/gbm_predictions.csv', sep='')
logit.df <- read.table(logit.predictions, sep=',', header=T)
rf.df <- read.table(rf.predictions, sep=',', header=T)
net.df <- read.table(net.predictions, sep=',', header=T)
gbm.df <- read.table(gbm.predictions, sep=',', header=T)
predictions <- cbind(logit.df$pred, rf.df$pred, net.df$pred, gbm.df$pred)

pred <- (1/3)*logit.df$pred + (1/6)*rf.df$pred + (1/3)*net.df$pred + (1/6)*gbm.df$pred
ensemble.predictions <- paste('F:/Grad Projects/March Mania/kaggle-march-madness-2014-master/data/test_predictions.csv', sep='')
write.csv(data.frame(id=logit.df$id, pred=pred), file=ensemble.predictions, quote=F, row.names=F)

source('load_data.R')

process.data <- function(data) {
    data$wlk_hrank_last_vs_first <- NULL
    data$dol_hrank_last_vs_first <- NULL
    data$col_hrank_last_vs_first <- NULL
    data$sag_hrank_last_vs_first <- NULL
    data$wlk_lrank_last_vs_first <- NULL
    data$dol_lrank_last_vs_first <- NULL
    data$col_lrank_last_vs_first <- NULL
    data$sag_lrank_last_vs_first <- NULL
    data$wlk_ps_last_vs_first <- NULL
    data$dol_ps_last_vs_first <- NULL
    data$col_ps_last_vs_first <- NULL
    data$sag_ps_last_vs_first <- NULL
    data$wlk_hrank_last_vs_first_ps <- NULL
    data$dol_hrank_last_vs_first_ps <- NULL
    data$col_hrank_last_vs_first_ps <- NULL
    data$sag_hrank_last_vs_first_ps <- NULL
    data$wlk_lrank_last_vs_first_ps <- NULL
    data$dol_lrank_last_vs_first_ps <- NULL
    data$col_lrank_last_vs_first_ps <- NULL
    data$sag_lrank_last_vs_first_ps <- NULL
    data$hseed_median_ps <- NULL
    data$lseed_median_ps <- NULL
    data$col_lrank_last <- NULL
    data$sag_lrank_last <- NULL
    data$wlk_hrank_last <- NULL
    data$lseed_skew_eps <- NULL
    data$lseed_median_eps <- NULL
    data$lseed_avg_eps <- NULL
    data$hseed_kurtosis_eps <- NULL
    data$col_lrank_first <- NULL
    data$dol_hrank_first <- NULL
    data$dol_hrank_last <- NULL
    data$hseed_std_eps <- NULL
    data$lseed_kurtosis_eps <- NULL
    data$sag_lrank_first <- NULL
    data$sag_hrank_first <- NULL
    data$lseed_std_eps <- NULL
    data$hseed_avg_eps <- NULL

    data$hseed_median_eps <- NULL
    data$hseed_skew_eps <- NULL
    data$wlk_hrank_first <- NULL
    data$wlk_lrank_first <- NULL
    data$wlk_lrank_last <- NULL
    data$dol_lrank_first <- NULL
    data$dol_lrank_last <- NULL
    data$col_hrank_first <- NULL
    data$col_hrank_last <- NULL
    data$sag_hrank_last <- NULL

    data$col_ps_last <- NULL
    data$sag_ps_last <- NULL
    data$wlk_ps_last <- NULL
    data$dol_ps_last <- NULL

    data$lseed_std_ps <- NULL
    data$hseed_std_ps <- NULL
    data$hseed_avg_ps <- NULL
    data$lseed_avg_ps <- NULL
    data$hseed_kurtosis_ps <- NULL
    data$lseed_kurtosis_ps <- NULL

    data$hseed <- NULL
    data$lseed <- NULL
    data$hseed_record <- NULL
    data$lseed_record <- NULL

    #data$hseed_skew_ps <- NULL
    #data$lseed_skew_ps <- NULL
    #data$dol_ps_first <- NULL
    #data$col_ps_first <- NULL
    #data$sag_ps_first <- NULL
    #data$wlk_ps_first <- NULL
    return(data)
}

# prune features and train logit model
data <- process.data(data)

# Features left after pruning
# "target"  "hseed_skew_ps" "lseed_skew_ps" "wlk_ps_first"  "dol_ps_first"  "col_ps_first"  "sag_ps_first" 

dim(data)
names(data)
## target is winscore-losescore

head(data$target)
data$target <- as.numeric(data$target > 0)
model <- glm(target~., data=data, family=binomial)

# apply to test data and write to output
TEST_SEASON <- 'S'
TEST_OUTPUT <- paste('F:/Grad Projects/March Mania/kaggle-march-madness-2014-master/data/logit_predictions.csv', sep='')

test.data <- process.data(test.data)
predictions <- predict(model, test.data, type='response')
output.game.id <- rep('', dim(test.data)[1])
output.pred <- rep(0, dim(test.data)[1])
attach(test.data)
for (i in 1:dim(test.data)[1]) {
    pwin <- predictions[i]
    team1 <- hteam[i]
    team2 <- lteam[i]
    if (hteam[i] > lteam[i]) {
        pwin <- 1 - pwin
        team1 <- lteam[i]
        team2 <- hteam[i]
    }
    game.id <- paste(TEST_SEASON, as.character(team1), as.character(team2), sep='_')
    output.game.id[i] <- game.id
    output.pred[i] <- pwin
}
detach(test.data)

output <- data.frame(id=output.game.id, pred=output.pred)
write.csv(output, file=TEST_OUTPUT, quote=F, row.names=F)

> m <- matrix(nrow = 2, ncol = 3)

> mx <- list(1, "a", TRUE, 1 + 4i)

> x<- 1:4

good <- complete.cases(data$Ozone, data$Solar.R, data$Temp)
mean(data$Solar.R[good & data$Ozone > 31 & data$Temp > 90])
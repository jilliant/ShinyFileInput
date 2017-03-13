# Want a new dataset?

# Base Dataset - 100 observations
OrderId <- c(sample(100:1000, 100, replace=FALSE))
Year <- c(rep(2017,100))
Price <- c(runif(100, min=0, max=100))
Quantity <- c(runif(100, min=0, max=100))
  
basedata <- cbind(OrderId, Year, Price, Quantity)

write.csv(basedata,"base.csv", row.names=FALSE)
  
# CSV for Filtering
# a subset of OrderIds and Year 
# sample without replacement
myfilter <- basedata[sample(1:nrow(basedata), 10,
                          replace=FALSE),]
# drop the price and quantity 
myfilter <- data.frame(myfilter)
myfilter <- subset(myfilter, select = c(1,2))

write.csv(myfilter,"filter.csv", row.names=FALSE)
library(ggplot2)
cereals.df <- read.csv("~\\Cereals.csv", header = TRUE)
head(cereals.df, 9)
summary(cereals.df)
View(cereals.df)

# compute mean, standard dev., min, max, median, length, and missing values for all
# quantitative variables which is all the colums in the dataset except the first three columns.
data.frame(mean=sapply(cereals.df[,-c(1:3)], mean, na.rm=TRUE), 
           sd=sapply(cereals.df[,-c(1:3)], sd, na.rm=TRUE), 
           min=sapply(cereals.df[,-c(1:3)], min, na.rm=TRUE), 
           max=sapply(cereals.df[,-c(1:3)], max, na.rm=TRUE), 
           median=sapply(cereals.df[,-c(1:3)], median, na.rm=TRUE), 
           length=sapply(cereals.df[,-c(1:3)], length),
           miss.val=sapply(cereals.df[,-c(1:3)], function(x) 
             sum(length(which(is.na(x))))))

## histogram of calories
hist(cereals.df$calories, xlab = "calories")
# alternative plot with ggplot
ggplot(cereals.df) + geom_histogram(aes(x = calories), binwidth = 10)

## histogram of protein
hist(cereals.df$protein, xlab = "protein")
# alternative plot with ggplot
ggplot(cereals.df) + geom_histogram(aes(x = protein), binwidth = 1)

## histogram of fat
hist(cereals.df$fat, xlab = "fat")
# alternative plot with ggplot
ggplot(cereals.df) + geom_histogram(aes(x = fat), binwidth = 1)

## histogram of sodium
hist(cereals.df$sodium, xlab = "sodium")
# alternative plot with ggplot
ggplot(cereals.df) + geom_histogram(aes(x = sodium), binwidth = 50)

## histogram of fiber
hist(cereals.df$fiber, xlab = "fiber")
# alternative plot with ggplot
ggplot(cereals.df) + geom_histogram(aes(x = fiber), binwidth = 2)

## histogram of carbo
hist(cereals.df$carbo, xlab = "carbohydrates")
# alternative plot with ggplot
ggplot(cereals.df) + geom_histogram(aes(x = carbo), binwidth = 2, na.rm=TRUE) +
  xlab("carbohydrates")

## histogram of sugars
hist(cereals.df$sugars, xlab = "sugars")
# alternative plot with ggplot
ggplot(cereals.df) + geom_histogram(aes(x = sugars), binwidth = 1, na.rm=TRUE)

## histogram of potass
hist(cereals.df$potass, xlab = "potassium")
# alternative plot with ggplot
ggplot(cereals.df) + geom_histogram(aes(x = potass), binwidth = 50, na.rm=TRUE) +
  xlab("potassium")

## histogram of vitamins
hist(cereals.df$vitamins, xlab = "vitamins")
# alternative plot with ggplot
ggplot(cereals.df) + geom_histogram(aes(x = vitamins), binwidth = 5, na.rm=TRUE)

## histogram of shelf
hist(cereals.df$shelf, xlab = "shelf")
# alternative plot with ggplot
ggplot(cereals.df) + geom_histogram(aes(x = shelf), binwidth = .5, na.rm=TRUE)

## histogram of weight
hist(cereals.df$weight, xlab = "weight")
# alternative plot with ggplot
ggplot(cereals.df) + geom_histogram(aes(x = weight), binwidth = .1, na.rm=TRUE)

## histogram of cups
hist(cereals.df$cups, xlab = "cups")
# alternative plot with ggplot
ggplot(cereals.df) + geom_histogram(aes(x = cups), binwidth = .2, na.rm=TRUE)

## histogram of rating
hist(cereals.df$rating, xlab = "rating")
# alternative plot with ggplot
ggplot(cereals.df) + geom_histogram(aes(x = rating), binwidth = 10, na.rm=TRUE)

dev.off()
## boxplot of calories for different values of type(cold or hot)
boxplot(cereals.df$calories ~ cereals.df$type, xlab = "type(cold or hot)", ylab = "calories")
dev.off()
# alternative plot with ggplot
ggplot(cereals.df) + geom_boxplot(aes(x = as.factor(type), y = calories)) + xlab("type") +
  scale_x_discrete(labels=c("C" = "Cold", "H" = "Hot"))

#### Read in the ToyotaCorolla csv file

corolla.df <- read.csv("C:\\Users\\kbsta\\R work\\MIS510 data\\ToyotaCorolla.csv", header = TRUE)  # load data


### Explore the data using various functions

dim(corolla.df)  # find the dimension of data frame
head(corolla.df)  # show the first six rows
View(corolla.df)  # show all the data in a new tab

Sys.time()

#more ways to explore data
corolla.df[1:10, ]  # show the first 10 rows of each of the columns 
corolla.df[9, 1:10]  # show the ninth row of the first 10 columns
corolla.df[20:40, c(2:3, 6, 8, 11)]  # show the 20th thru the 40th rows of selected columns
corolla.df[, 3]  # show the whole third column
corolla.df$Price  # a different way to show the whole 3rd column
corolla.df$Id[1:10]  # show the first 10 rows of the first column
length(corolla.df$Model)  # find the length of the Model column
mean(corolla.df$Price)  # find the mean of the first column
summary(corolla.df)  # find summary statistics for each column

###Look at the class at levels of categorical variables Fuel_Type and Color
class(corolla.df$Fuel_Type) # Fuel_Type is a factor variable
levels(corolla.df$Fuel_Type)  # It can take one of three levels

class(corolla.df$Color)  # Color is a factor variable
levels(corolla.df$Color)  # It can take one of 10 values

#### Table 2.6
# Option 1: use dummies package

library(dummies)
dummytest.df <- dummy.data.frame(data = corolla.df, names=c("Fuel_Type", "Color"), sep = "_")
names(dummytest.df)
dummytest.df[1:10, c(8:10, 13:22)]  # show the first 10 rows of the new dummy colomns

# Option 2: use model.matrix() to convert Fuel_Type and Color categorical variables in the data frame into a set of dummy variables. We must then turn the resulting data matrix back into 
# a data frame for further work.
temp <- model.matrix(~ 0 + Fuel_Type + Color, data = corolla.df)
dummy2test.df <- as.data.frame(temp)
t(t(names(dummy2test.df)))  # check the names of the dummy variables
head(dummy2test.df)

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



#### Table 2.9

# use set.seed() to get the same partitions when re-running the R code.
set.seed(1)

## partitioning into training (60%) and validation (40%)
# randomly sample 60% of the row IDs for training; the remaining 40% serve as
# validation
train.rows <- sample(rownames(corolla.df), dim(corolla.df)[1]*0.6)
# collect all the columns with training row ID into training set:
train.data <- corolla.df[train.rows, ]
# assign row IDs that are not already in the training set, into validation 
valid.rows <- setdiff(rownames(corolla.df), train.rows) 
valid.data <- corolla.df[valid.rows, ]

dim(train.data)
dim(valid.data)

# alternative code for validation (works only when row names are numeric): 
# collect all the columns without training row ID into validation set 
valid.data <- corolla.df[-train.rows, ] # does not work in this case

## partitioning into training (50%), validation (30%), test (20%)
# randomly sample 50% of the row IDs for training
train.rows <- sample(rownames(corolla.df), dim(corolla.df)[1]*0.5)

# sample 30% of the row IDs into the validation set, drawing only from records
# not already in the training set
# use setdiff() to find records not already in the training set
valid.rows <- sample(setdiff(rownames(corolla.df), train.rows), 
                     dim(corolla.df)[1]*0.3)

# assign the remaining 20% row IDs serve as test
test.rows <- setdiff(rownames(corolla.df), union(train.rows, valid.rows))

# create the 3 data frames by collecting all columns from the appropriate rows 
train.data <- corolla.df[train.rows, ]
valid.data <- corolla.df[valid.rows, ]
test.data <- corolla.df[test.rows, ]

dim(train.data)
dim(valid.data)
dim(test.data)



#### Table 2.11

reg <- lm(TOTAL_VALUE ~ .-TAX, data = housing.df, subset = train.rows) # remove variable "TAX"
tr.res <- data.frame(train.data$TOTAL_VALUE, reg$fitted.values, reg$residuals)
head(tr.res)



#### Table 2.12

pred <- predict(reg, newdata = valid.data)
vl.res <- data.frame(valid.data$TOTAL_VALUE, pred, residuals = 
                       valid.data$TOTAL_VALUE - pred)
head(vl.res)


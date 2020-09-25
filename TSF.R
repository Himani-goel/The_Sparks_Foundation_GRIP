library(tidyverse)
library(caret)
library(party)

#import the data
data.iris <- read_csv("C:\\Users\\HIMANI\\Downloads\\Iris.csv")

#look at the data
glimpse(data.iris)
summary(data.iris)

# Split the data into training and test set
training.samples <- data.iris$Species %>%
  createDataPartition(p = 0.8, list = FALSE)
train.data  <- data.iris[training.samples,-1]
test.data <- data.iris[-training.samples,-1]

#Fit a model on the data
model <- train( Species ~., data = train.data, method = "ctree2",
                trControl = trainControl("cv", number = 10))
model

#visualize the Decision Tree
plot(model$finalModel , main ="Decision Tree Classifier For Species")

# predictions on the test data
predicted.classes <- model %>% predict(test.data)

# model accuracy rate on test data
mean(predicted.classes == test.data$Species)

# We have an accuracy of 93% , that means our model is good fit to the data .
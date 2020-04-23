cat("\14")
library(neuralnet)
# custom normalization function
normalize <- function(x) { 
  return((x - min(x)) / (max(x) - min(x)))
}
# apply normalization to entire data frame
concrete<-read.csv("C:/Users/sonih/Downloads/concrete.csv")
concrete_norm <- as.data.frame(lapply(concrete, normalize))
# create training and test data
concrete_train <- concrete_norm[1:773, ]
concrete_test <- concrete_norm[774:1030, ]

## Training a model on the data ----
# train the neuralnet model

# simple ANN with only a single hidden neuron
concrete_model <- neuralnet(formula = strength ~ .,
                            data = concrete_train)
# visualize the network topology
windows()
plot(concrete_model)
## Evaluating model performance ----
# obtain model results
model_results <- compute(concrete_model, concrete_test[1:8])
# obtain predicted strength values
predicted_strength <- model_results$net.result
# examine the correlation between predicted and actual values
cor(predicted_strength, concrete_test$strength)
## Improving model performance ----
# a more complex neural network topology with 5 hidden neurons
concrete_model2 <- neuralnet(strength ~ .,data = concrete_train,
                             hidden =c(4,2,4))
# plot the network
windows()
plot(concrete_model2)
# evaluate the results as we did before
model_results2 <- compute(concrete_model2, concrete_test[1:8])
predicted_strength2 <- model_results2$net.result
cor(predicted_strength2, concrete_test$strength)
library(glmnet)
library(Matrix)
library(foreach)
library(pROC)
PPI <- read.csv(".\Input\PPI.csv",header = T,row.names = 1)
CoExpression <- read.csv(".\Input\co-expression.csv",header = T,row.names = 1)
Data <- read.csv(".\Input\ExampleData.csv",header = T)
#Generate Candidate GuidingNet
cutoff <- 0.1 #set cutoff
CoExpression <- abs(CoExpression)
PPIandCoExPression <- PPI*CoExpression
PPIandCoExPression <- as.matrix(PPIandCoExPression)
PPIandCoExPression[which(PPIandCoExPression<=cutoff)]<-0
FirstTFWeight <- colSums(PPIandCoExPression)
SecondTFWeight <- rowSums(PPIandCoExPression)
names(FirstTFWeight) <- colnames(PPIandCoExPression)
names(SecondTFWeight) <- rownames(PPIandCoExPression)
a1 <- which(FirstTFWeight>0)
a2 <- which(SecondTFWeight>0)
CGN <- as.matrix(PPIandCoExPression[a2,a1])#CGN is the Candidate GuidingNet 
colnames(CGN) <- names(a1) 
rownames(CGN) <- names(a2)
allTFweight <- c(FirstTFWeight,SecondTFWeight)
allTFweight <- allTFweight[order(names(allTFweight))]
TFofCGN <- allTFweight[which(allTFweight>0)]
Weight <- 1/TFofCGN

#Fit Adaptive Lasso regularized logistic regression
TFRelatedFeatures <- Data[,1:(ncol(Data)-3)]
TFUnrelatedFeatures<- Data[,c(ncol(Data)-2,ncol(Data)-1)]
Label <- Data[,ncol(Data)]
allTF <- names(TFRelatedFeatures)
TF <- TFRelatedFeatures[which(allTFweight>0)]
TrainingData <- data.frame(TF,TFUnrelatedFeatures,Label)
w <- c(Weight,0,0)
require(caret)
set.seed(2)
a <- ncol(TrainingData) -1
folds <- createFolds(y=TrainingData$Label,k=10)
#10-Fold Cross-Validation
#fold 1 
fold_test <- TrainingData[folds[[1]],]   
fold_train <- TrainingData[-folds[[1]],]
y1 <- fold_test$Label
y2 <- fold_train$Label
x1 <- fold_test[,1:a]
x2 <- fold_train[,1:a]
X1 <- as.matrix(x1)
X2 <- as.matrix(x2)
fold_pre <- cv.glmnet(X2,y2,family = "binomial",penalty.factor=w)
fold_predict1 <- predict(fold_pre,type='response',X1 )
fold_predict1 <- as.numeric(fold_predict1)
names(fold_predict1) <- row.names(fold_test)
true_value1 <- y1
#fold 2 
fold_test <- TrainingData[folds[[2]],]   
fold_train <- TrainingData[-folds[[2]],]   
y1 <- fold_test$Label
y2 <- fold_train$Label
x1 <- fold_test[,1:a]
x2 <- fold_train[,1:a]
X1 <- as.matrix(x1)
X2 <- as.matrix(x2)
fold_pre <- cv.glmnet(X2,y2,family = "binomial",penalty.factor=w)
fold_predict2 <- predict(fold_pre,type='response',X1 )
fold_predict2 <- as.numeric(fold_predict2)
names(fold_predict2) <- row.names(fold_test)
true_value2 <- y1
#fold 3 
fold_test <- TrainingData[folds[[3]],]   
fold_train <- TrainingData[-folds[[3]],]   
y1 <- fold_test$Label
y2 <- fold_train$Label
x1 <- fold_test[,1:a]
x2 <- fold_train[,1:a]
X1 <- as.matrix(x1)
X2 <- as.matrix(x2)
fold_pre <- cv.glmnet(X2,y2,family = "binomial",penalty.factor=w)
fold_predict3 <- predict(fold_pre,type='response',X1 )
fold_predict3 <- as.numeric(fold_predict3)
true_value3 <- y1
names(fold_predict3) <- row.names(fold_test)
#fold 4 
fold_test <- TrainingData[folds[[4]],]   
fold_train <- TrainingData[-folds[[4]],]   
y1 <- fold_test$Label
y2 <- fold_train$Label
x1 <- fold_test[,1:a]
x2 <- fold_train[,1:a]
X1 <- as.matrix(x1)
X2 <- as.matrix(x2)
fold_pre <- cv.glmnet(X2,y2,family = "binomial",penalty.factor=w)
fold_predict4 <- predict(fold_pre,type='response',X1 )
fold_predict4 <- as.numeric(fold_predict4)
names(fold_predict4) <- row.names(fold_test)
true_value4 <- y1
#fold 5 
fold_test <- TrainingData[folds[[5]],]   
fold_train <- TrainingData[-folds[[5]],]  
y1 <- fold_test$Label
y2 <- fold_train$Label
x1 <- fold_test[,1:a]
x2 <- fold_train[,1:a]
X1 <- as.matrix(x1)
X2 <- as.matrix(x2)
fold_pre <- cv.glmnet(X2,y2,family = "binomial",penalty.factor=w)
fold_predict5 <- predict(fold_pre,type='response',X1 )
fold_predict5 <- as.numeric(fold_predict5)
names(fold_predict5) <- row.names(fold_test)
true_value5 <- y1
#fold 6 
fold_test <- TrainingData[folds[[6]],]   
fold_train <- TrainingData[-folds[[6]],]   
y1 <- fold_test$Label
y2 <- fold_train$Label
x1 <- fold_test[,1:a]
x2 <- fold_train[,1:a]
X1 <- as.matrix(x1)
X2 <- as.matrix(x2)
fold_pre <- cv.glmnet(X2,y2,family = "binomial",penalty.factor=w)
fold_predict6 <- predict(fold_pre,type='response',X1 )
fold_predict6 <- as.numeric(fold_predict6)
names(fold_predict6) <- row.names(fold_test)
true_value6 <- y1
#fold 7
fold_test <- TrainingData[folds[[7]],]   
fold_train <- TrainingData[-folds[[7]],]   
y1 <- fold_test$Label
y2 <- fold_train$Label
x1 <- fold_test[,1:a]
x2 <- fold_train[,1:a]
X1 <- as.matrix(x1)
X2 <- as.matrix(x2)
fold_pre <- cv.glmnet(X2,y2,family = "binomial",penalty.factor=w)
fold_predict7 <- predict(fold_pre,type='response',X1 )
fold_predict7 <- as.numeric(fold_predict7)
names(fold_predict7) <- row.names(fold_test)
true_value7 <- y1
#fold 8 
fold_test <- TrainingData[folds[[8]],]   
fold_train <- TrainingData[-folds[[8]],]   
y1 <- fold_test$Label
y2 <- fold_train$Label
x1 <- fold_test[,1:a]
x2 <- fold_train[,1:a]
X1 <- as.matrix(x1)
X2 <- as.matrix(x2)
fold_pre <- cv.glmnet(X2,y2,family = "binomial",penalty.factor=w)
fold_predict8 <- predict(fold_pre,type='response',X1 )
fold_predict8 <- as.numeric(fold_predict8)
names(fold_predict8) <- row.names(fold_test)
true_value8 <- y1
#fold 9 
fold_test <- TrainingData[folds[[9]],]   
fold_train <- TrainingData[-folds[[9]],]   
y1 <- fold_test$Label
y2 <- fold_train$Label
x1 <- fold_test[,1:a]
x2 <- fold_train[,1:a]
X1 <- as.matrix(x1)
X2 <- as.matrix(x2)
fold_pre <- cv.glmnet(X2,y2,family = "binomial",penalty.factor=w)
fold_predict9 <- predict(fold_pre,type='response',X1 )
fold_predict9 <- as.numeric(fold_predict9)
names(fold_predict9) <- row.names(fold_test)
true_value9 <- y1
#fold 10 
fold_test <- TrainingData[folds[[10]],]   
fold_train <- TrainingData[-folds[[10]],]  
y1 <- fold_test$Label
y2 <- fold_train$Label
x1 <- fold_test[,1:a]
x2 <- fold_train[,1:a]
X1 <- as.matrix(x1)
X2 <- as.matrix(x2)
fold_pre <- cv.glmnet(X2,y2,family = "binomial",penalty.factor=w)
fold_predict10 <- predict(fold_pre,type='response',X1 )
fold_predict10 <- as.numeric(fold_predict10)
true_value10 <- y1
names(fold_predict10) <- row.names(fold_test)
#ROC curve and AUC value 
fold_predict <- c(fold_predict1,fold_predict2,fold_predict3,fold_predict4,fold_predict5,fold_predict6,fold_predict7,fold_predict8,fold_predict9,fold_predict10)
true_value <- c(true_value1,true_value2,true_value3,true_value4,true_value5,true_value6,true_value7,true_value8,true_value9,true_value10)
modelroc <- roc(true_value,fold_predict)
AUCvalue <- auc(modelroc)
AUCvalue <- round(AUCvalue,4)
plot(modelroc, col="red",main = "GuidingNet",auc.polygon=TRUE,auc.polygon.col="white",legacy.axes=TRUE,grid.col=c("black", "black"),xaxs="i",yaxs="i",font.lab=2,cex.main=2,cex.lab=2)
AUC<-c("AUC=")
AUC<-paste(AUC,AUCvalue) 
legend("bottomright",legend = AUC,col=c("red"),lwd = 2,cex=1.8)

probability <- fold_predict
#Generate GuidingNet
fit<-fold_pre
coefficients <- coef(fit,s=fit$lambda.min)
TFcoefficents <- coefficients[2:(length(coefficients)-2),1]
Active.Index<-which(TFcoefficents!=0)
TFofGN <- names(Active.Index)
FirstTFofCGN <- colnames(CGN)
SecondTFofCGN <- rownames(CGN)
c <- c()
cNames <- c()
for(i in FirstTFofCGN) {
  l <- length(which(i == TFofGN))
  if( l > 0 ){
    loc <- which(i == FirstTFofCGN)  
    c <- c(c,loc)
    cNames <- c(cNames,i)
  }
}
r <- c()
rNames <- c()
for(i in SecondTFofCGN) {
  l <- length(which(i == TFofGN))
  if( l > 0 ){
    loc <- which(i == SecondTFofCGN)  
    r <- c(r,loc) 
    rNames <- c(rNames,i)
  }
  
}
GN <- as.matrix(CGN[r,c])
colnames(GN) <- cNames
rownames(GN) <- rNames # GN is the GuidingNet
write.csv(probability, "./Output/probability.csv")
write.csv(GN, "./Output/GuidingNet TF network.csv")

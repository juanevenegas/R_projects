pacman::p_load(ggplot2, data.table, scales, corrplot, car, psych, broom, readxl, glmnet, NbClust, cluster, caret)

#load data----
setwd('C:/Users/Juan Esteban Venegas/Desktop/Machine Learning Learning/Greatlearning/Greatlearning_projects/Project_4_Thera_Bank')
getwd()

ReadMe <- as.data.table(read_xlsx(paste0(getwd(),'/Thera Bank_Personal_Loan_Modelling-dataset-1.xlsx'), sheet = 'ReadMe'))
names(ReadMe) <- c('Variable', 'Description')
ReadMe <- ReadMe[!is.na(Variable)]

Thera_Bank <- as.data.table(read_xlsx(paste0(getwd(),'/Thera Bank_Personal_Loan_Modelling-dataset-1.xlsx'), sheet = 'Bank_Personal_Loan_Modelling'))
names(Thera_Bank) <- gsub("\\.","",make.names(gsub("(?<=[\\s])\\s*|^\\s+|\\s+|\\.$", "_", names(Thera_Bank), perl=TRUE)))

Thera_Bank[,c('Education', 'Personal_Loan', 'Securities_Account', 'CD_Account', 'Online', 'CreditCard')] <- lapply(Thera_Bank[,c('Education', 'Personal_Loan', 'Securities_Account', 'CD_Account', 'Online', 'CreditCard')] , factor)
colSums(is.na(Thera_Bank))

#Exploratory Data Analysis----
#Get a clean dataset to understand the relationship between variables before doing any imputation.
Thera_Bank_EDA <- Thera_Bank[!is.na(Family_members)]
#Outliers
numeric_variables <- names(which(sapply(Thera_Bank,is.numeric) & !(names(Thera_Bank) %in% c('ID', 'ZIP_Code'))))
par(mfrow = c(1,length(numeric_variables)))
outliers_list <- list()
for(i in 1:length(numeric_variables)){
  plot <- boxplot(Thera_Bank[,numeric_variables[i], with = FALSE], ylab = numeric_variables[i])
  outliers_list[[numeric_variables[i]]] <- Thera_Bank[eval(parse(text = numeric_variables[i])) %in% plot$out]
  outliers_list[[numeric_variables[i]]]$outlier <- numeric_variables[i]
  }

outliers_dt <- rbindlist(outliers_list)
outliers_cnt <- outliers_dt[,.(outlier_count = .N), by = .(ID)][order(-outlier_count)]
table(outliers_cnt$outlier_count)
Thera_Bank <- outliers_cnt[Thera_Bank, on = 'ID']


#Experience has negative values, Income has outliers on the top, CCAvg has outliers on the top and Mortgage has outliers on the top.
#Median of Mortgage is 0


       
       
       
       
       
       
       
       
#Prepare data----
dmy <- dummyVars(" ~ .", data = Thera_Bank)
Thera_Bank <- data.frame(predict(dmy, newdata = Thera_Bank))
head(Thera_Bank,4)





#Review individual variables

densityPlot(Thera_Bank$Age_in_years)

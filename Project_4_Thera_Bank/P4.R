pacman::p_load(ggplot2, data.table, scales, corrplot, car, psych, broom, readxl, glmnet, nbClust, cluster, caret)

#load data----
setwd('C:/Users/Juan Esteban Venegas/Desktop/Machine Learning Learning/Greatlearning/Project_4_Thera_Bank')
getwd()

ReadMe <- as.data.table(read_xlsx(paste0(getwd(),'/Thera Bank_Personal_Loan_Modelling-dataset-1.xlsx'), sheet = 'ReadMe'))
names(ReadMe) <- c('Variable', 'Description')
ReadMe <- ReadMe[!is.na(Variable)]

Thera_Bank <- as.data.table(read_xlsx(paste0(getwd(),'/Thera Bank_Personal_Loan_Modelling-dataset-1.xlsx'), sheet = 'Bank_Personal_Loan_Modelling'))
names(Thera_Bank) <- gsub("\\.","",make.names(gsub("(?<=[\\s])\\s*|^\\s+|\\s+|\\.$", "_", names(Thera_Bank), perl=TRUE)))

Thera_Bank[,c('Education', 'Personal_Loan', 'Securities_Account', 'CD_Account', 'Online', 'CreditCard', 'ZIP_Code')] <- lapply(Thera_Bank[,c('Education', 'Personal_Loan', 'Securities_Account', 'CD_Account', 'Online', 'CreditCard', 'ZIP_Code')] , factor)

#Review individual variables

densityPlot(Thera_Bank$Age_in_years)

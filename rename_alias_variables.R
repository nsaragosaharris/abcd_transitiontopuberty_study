# Written by Natalie Saragosa-Harris.
# June 2020.
# This code renames the ABCD variables to have shorter and more interpretable names.

library(plyr)
library(glue)
# Replace with your directories here.
variabledirectory <- ""
outputdirectory <- ""

setwd(variabledirectory)
variablenames <- read.csv("VariableDefinitions.csv")
setwd(outputdirectory)
#nda20 <- readRDS('nda20.rds')
nda20 <- read.csv('nda20.csv')

variables <- as.data.frame(variablenames$Variable.Name)
variables <- variables[!apply(variables == "", 1, all),] # Remove empty rows.
variables <- tolower(variables)  # Make sure they are all lowercase.
missingvariables <- setdiff(variables,colnames(nda30)) # List variables that are in the "variable names" file but not in the data file.
missingvariables <- as.data.frame(missingvariables)
colnames(missingvariables) <- "Variable.Name"


print(glue('These variable names do not appear in the data: {missingvariables}.'))
#print(missingvariables)

# Get the aliases for all of the variable names.
aliases <- variablenames[,c("Variable.Name","Aliases")]
aliases <- aliases[!apply(aliases == "", 1, all),] # Remove empty rows.
aliases$Variable.Name <- tolower(aliases$Variable.Name)  # Make sure they are all lowercase.
aliases$Aliases <- tolower(aliases$Aliases) 
aliases <- as.data.frame(aliases)


missingvariables <- merge(missingvariables,aliases, by = "Variable.Name")
# Replace with aliases.
# For the variables that are not in the data frame, check if the alias exists in the data frame.

no_aliases <- subset(missingvariables, Aliases== "")
print("No alias provided for the following variables: ")
print(no_aliases$Variable.Name)

# Keep only the ones that have an alias.
missingvariables <- subset(missingvariables, Aliases!= "")

# Do these aliases exist in the dataframe?
aliases_in_data <- intersect(missingvariables$Aliases,colnames(nda30))
print("Alias exists in dataframe for the following variables: ")
print(aliases_in_data)

aliases_not_in_data <- setdiff(missingvariables$Aliases,colnames(nda30))
print("Neither the original variable name nor its alias exist in the dataframe for the following variables: ")
print(aliases_not_in_data)
# These variables need to be calculated so they are not in the dataframe currently.
# bis_y_ss_basm_rr.
# bis_y_ss_basm_rr_nm.

# Go through the variables that do have aliases in the data.
for (i in 1:length(aliases_in_data)){
  
  # Find that alias in the dataframe and in the aliases dataframe.
  # Rename the column from the alias to the correct Variable Name.
  alias <- aliases_in_data[i]
  # Find alias and the original variable name in "aliases" data frame.
  new_name <- subset(aliases, Aliases == alias)
  new_name <- new_name$Variable.Name
  # Find alias in dataframe and replace with the new name.
  names(nda30)[names(nda30) == alias] <- new_name
}

print("The following variables were not found in the data frame under this name or an alias: ")
print(setdiff(variables,colnames(nda30)))

# The bisbas ones need to be calculated (see definition in variable definitions file).
# bisbas_ss_basm_rr.
# bisbas_ss_basm_rr_nm.

# Save the dataframe with the new variable names.
setwd(outputdirectory)

# As a last step we can save the data in R's native file format.

saveRDS(nda30, glue('{outputdirectory}/nda30.rds'))

names.nda30=colnames(nda30)

save(file="names.nda30.RData",names.nda30)

# Save as .csv file as well.
write.csv(nda30, glue('{outputdirectory}/nda30.csv', row.names = FALSE))

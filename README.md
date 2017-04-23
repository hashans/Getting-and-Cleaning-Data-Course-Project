# Getting-and-Cleaning-Data-Course-Project
R program to getting and cleaning data 

A simple R program that performs a data cleansing for a given data set. This particular R script simply 

1. Downloads the zip file
2. Unzips it
3. Loads training and testing data sets along with subjects as well as activity labelling file
4. Merging the data and filtering columns having mean and standard deviation values
5. Aggregating mean of all values based on subject and activity
6. Generating `tidyData.txt` in the current working directory.

In order to run the script, you just have to execute `Rscript run_analysis.R`.
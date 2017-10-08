## Getting and Cleaning Data

This repo contains the project work for the week4 assignment of Getting and Cleaning Data.

# Repo Contant 

* Codebook.md     - Data indicating all the variables and summaries calculated, along with units, and all the other relevant information.
* README.md       - This file that explains the repo.
* run_analysis.R  - The script file that makes the tidy data.

# About Data

The data used in this assignment is comming from UCI(UC Irvine).The data used in the analysis is acceleramator and gyrocope data collected from Samsung Galaxy S Smartphone.The data is collected trough experiments conducted on 30 voluntrees within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist.

For each record in the dataset it is provided: 
- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration. 
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

# Script

The script expects UCI_HAR_Dataset in the folder where the script is being run. And the script uses following libraries.

    * dplyr
    * data.table


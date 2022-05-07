# Adding in MRI, menstruation, and hormone date and time variables.

library(dplyr)
library(here)
library(glue)

# Existing variables that are used in this script.
# iqc_mid_study_date: Date of first MID imaging series.
# iqc_mid_series_time: Time of first MID imaging series.
# hormone_sal_end_y: Hormone saliva sample time collection finished?
# menstrualcycle1_p: What was the date of the first day of your child's last period?
# interview_date_hormones [existing column that we rename in this script]: the 'interview_date' column specifically from hormone file (sph01.txt), renamed for clarity.

# Variables that are created in this script.
# iqc_mid_series_date_time [created]: iqc_mid_study_date + iqc_mid_series_time
# hormone_date_time [created]: interview_date_hormones + hormone_sal_end_y
# MRI_minus_hormone_date_time [created]:  iqc_mid_series_date_time - hormone_date_time [date/time variables]
# hormone_date_minus_last_period_date [created]: interview_date_hormones - menstrualcylcle1_p [dates only, no times added]

data_dir = ((dirname(here()))) 

# Read in MRI date and time variables from mriqcrp302.csv.
mriqcrp302 <- read.csv(file.path(data_dir,"ABCD","individualdatafiles","mriqcrp302.csv"), header = TRUE)
mriqcrp302 = mriqcrp302[-1,] # Remove first row (variable definitions).
# Add date and time columns to create new column.
mriqcrp302$iqc_mid_series_date_time <- paste(mriqcrp302$iqc_mid_study_date, mriqcrp302$iqc_mid_series_time, sep = " ")

# Read in sph01 file, rename interview_date as “interview_date_hormones”.
# Can ignore the rest of the columns from sph01 since we already merged those.
sph01 <- read.csv(file.path(data_dir,"ABCD","individualdatafiles","sph01.csv"), header = TRUE)
#In sph01, 'eventname' is called 'visit', so need to change that first.
sph01 <- dplyr::rename(sph01, "eventname" = "visit")
# Now rename "interview_date" to be "interview_date_hormones".
sph01 <- dplyr::rename(sph01, "interview_date_hormones" = "interview_date")
sph01 <- sph01[,c("src_subject_id","eventname","interview_date_hormones")]

# Read in existing data file.
#phase_folder = "exploratory"  # select the appropriate folder.
phase_folder = "confirmatory"
data_folder <- file.path(data_dir,"ABCD","derivatives",phase_folder)
file_name <- glue("nda30_{phase_folder}.csv")
fulldata <- read.csv(file.path(data_folder,file_name))
dim(fulldata) # 27321 by 2826 (exploratory); 27331  2826 (confirmatory). When call the define_dataframes script, will keep only the baseline data.

# Merge MRI data with fulldata.
duplicate_columns <- c("collection_id", "collection_title", "subjectkey", "interview_age","interview_date","sex","dataset_id")
mriqcrp302 = mriqcrp302[,!(names(mriqcrp302) %in% duplicate_columns)] # Ignore duplicate columns for merging purposes.
fulldata <- merge(fulldata, mriqcrp302,by=c("src_subject_id","eventname"),all.x =TRUE)

# Merge sph01 data with fulldata (should just be adding the "interview_date_hormones" column).
fulldata <- merge(fulldata,sph01,by=c("src_subject_id","eventname"),all.x =TRUE)
#dim(fulldata) # 27321 by 3056 (exploratory); 27331 by 3056 (confirmatory).
#str(fulldata$iqc_mid_series_date_time)

# Create a variable that takes into account both date and time for hormone collection.
fulldata$hormone_date_time <- paste(fulldata$interview_date_hormones, fulldata$hormone_sal_end_y, sep = " ")

# Make sure time columns are in correct format. I don't know the time zone but this should not differ within person so it should be fine.
# For the columns with times, I am going to just do "GMT", which is UTC (Universal Time, Coordinated), for everyone so that they don't somehow get two different time zones for the same person.
fulldata$iqc_mid_series_date_time <- as.POSIXlt(fulldata$iqc_mid_series_date_time, format = "%Y-%m-%d %H:%M", "GMT")
#str(fulldata$iqc_mid_series_date_time)
fulldata$hormone_date_time <- as.POSIXlt(fulldata$hormone_date_time, format = "%m/%d/%Y %H:%M", "GMT")
#str(fulldata$hormone_date_time)
fulldata$interview_date_hormones <- as.POSIXlt(fulldata$interview_date_hormones, format = "%m/%d/%Y", "GMT")
#str(fulldata$interview_date_hormones)
fulldata$menstrualcycle1_p <- as.POSIXlt(fulldata$menstrualcycle1_p, format = "%m/%d/%y", "GMT")
#str(fulldata$menstrualcycle1_p)

# Create a variable that takes into account the time difference (in minutes) between the MID task and hormone collection (using both date and time, as the dates may differ)
fulldata$MRI_minus_hormone_date_time <- fulldata$iqc_mid_series_date_time - fulldata$hormone_date_time
# It is in "difftime" format, so make it numeric.
fulldata$MRI_minus_hormone_date_time <- as.numeric(fulldata$MRI_minus_hormone_date_time)
# For some reason, in exploratory, it defaulted to use minutes but in confirmatory, it is in seconds?
# fulldata$MRI_minus_hormone_date_time <- fulldata$MRI_minus_hormone_date_time/60
# range(fulldata$MRI_minus_hormone_date_time, na.rm = TRUE) 
# exploratory: -1159 minutes (-19.32 hours) to 743088 minutes (516 days); confirmatory: -7468 (-124.47 hours) to 501331 (348 days).

# For exploratory: Remove the people who report last period being in 2007, 2009, and 2012 (I think these are errors). 
range(fulldata$menstrualcycle1_p,na.rm=TRUE) # "2007-05-28 GMT" to "2020-01-05 GMT".
fulldata$menstrualcycle1_p[which(fulldata$menstrualcycle1_p ==  as.POSIXlt("2007-05-28","GMT"))] <- NA
fulldata$menstrualcycle1_p[which(fulldata$menstrualcycle1_p ==  as.POSIXlt("2009-08-18","GMT"))] <- NA
fulldata$menstrualcycle1_p[which(fulldata$menstrualcycle1_p ==  as.POSIXlt("2012-01-01","GMT"))] <- NA
range(fulldata$menstrualcycle1_p,na.rm=TRUE) # "2015-08-17 GMT" to "2020-01-05 GMT"

# For confirmatory: Remove the people report last period being in 2001, 2007, and 2010 (I think these are errors). 
fulldata$menstrualcycle1_p[which(fulldata$menstrualcycle1_p ==  as.POSIXlt("2001-01-01 GMT","GMT"))] <- NA
fulldata$menstrualcycle1_p[which(fulldata$menstrualcycle1_p ==  as.POSIXlt("2007-02-06 GMT","GMT"))] <- NA
fulldata$menstrualcycle1_p[which(fulldata$menstrualcycle1_p ==  as.POSIXlt("2007-07-10 GMT" ,"GMT"))] <- NA
fulldata$menstrualcycle1_p[which(fulldata$menstrualcycle1_p ==  as.POSIXlt("2010-07-29 GMT","GMT"))] <- NA

# Create a variable that indicates, as of day of hormone collection, days since last period (using dates only).
fulldata$hormone_date_minus_last_period_date <- fulldata$interview_date_hormones - fulldata$menstrualcycle1_p
# It is in "difftime" format, so make it numeric.
# For some reason it defaults to put it in seconds, so let's divide by 86400 to put it into days.
fulldata$hormone_date_minus_last_period_date <- as.numeric(fulldata$hormone_date_minus_last_period_date)
fulldata$hormone_date_minus_last_period_date <- fulldata$hormone_date_minus_last_period_date/86400
range(fulldata$hormone_date_minus_last_period_date,na.rm=TRUE) # exploratory: 0 to 1342; confirmatory 0 to 1107.


# Create a variable that indicates time of hormone collection in minutes since midnight.
fulldata$hormone_sal_end_y <- as.POSIXct(fulldata$hormone_sal_end_y,format = "%H:%M") # Uses current date but that should be fine because midnight will as well.
midnight <- as.POSIXct("00:00",format = "%H:%M")
fulldata$hormone_sal_end_min_since_midnight <- fulldata$hormone_sal_end_y - midnight # Defaults to hours.
fulldata$hormone_sal_end_min_since_midnight <- as.numeric(fulldata$hormone_sal_end_min_since_midnight)
fulldata$hormone_sal_end_min_since_midnight <- fulldata$hormone_sal_end_min_since_midnight*60 # convert to minutes.
# range(fulldata$hormone_sal_end_min_since_midnight,na.rm=TRUE) # exploratory: 122 (2.03 hours) to 1299 (21.65 hours); confirmatory: 90 to 1292 (1.50 hours to 21.53 hours).

# Participant who reported date of last period being 1342 days prior (exploratory).
#fulldata$interview_date_hormones[which(fulldata$hormone_date_minus_last_period_date==1342)] #  "2019-04-20 GMT"
#fulldata$menstrualcycle1_p[which(fulldata$hormone_date_minus_last_period_date==1342)] # "2015-08-17 GMT"

# Participant who reported date of last period being 1107 days prior (confirmatory).
#fulldata$interview_date_hormones[which(fulldata$hormone_date_minus_last_period_date==1107)] #  "2019-02-23 GMT"
#fulldata$menstrualcycle1_p[which(fulldata$hormone_date_minus_last_period_date==1107)] # "2016-02-12 GMT"

# sum(!is.na(fulldata$iqc_mid_series_date_time)) # 8602 (exploratory); 8555 (confirmatory).

# baseline <- subset(fulldata,eventname == "baseline_year_1_arm_1")
# range(baseline$hormone_date_minus_last_period_date,na.rm=TRUE) # Range is 0 474 days (exploratory); 0 to 770 (confirmatory).
# baseline$interview_date_hormones[which(baseline$hormone_date_minus_last_period_date==474)] # "2017-04-29 GMT"
# baseline$menstrualcycle1_p[which(baseline$hormone_date_minus_last_period_date==474)] # "2016-01-11 GMT"
# baseline$interview_date_hormones[which(baseline$hormone_date_minus_last_period_date==770)] # "2017-03-26 GMT"
# baseline$menstrualcycle1_p[which(baseline$hormone_date_minus_last_period_date==770)] # "2015-02-15 GMT"
# So while one person has a very large value, it is possible that they had not had their period for over a year at the time of data collection.

# range(baseline$MRI_minus_hormone_date_time,na.rm=TRUE) # exporatory: -1159 (-19 hours) and 98051 (68 days); confirmatory: -7468 (-124.47 hours) to 107953 (74 days).

#write.csv(fulldata,glue("{data_dir}/ABCD/derivatives/{phase_folder}/nda30_{phase_folder}.csv"))

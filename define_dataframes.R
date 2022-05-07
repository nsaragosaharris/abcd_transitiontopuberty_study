# Call this function after you have loaded "nda20_exploratory.csv" into data frame named "fulldata".
# Instead of writing this long code for every single script, we are going to call one script to do it.
# This way, we can make sure we are all loading in the exact same data and working with the exact same dataframes because we are using identical code (from this one script).
# If we need to edit anything about our dataframes, we can do so in that single script.

# Covariates.
#      Random effects.
#           1. Family. (rel_family_id) # Make sure this is nested correctly and looks about right.
#           2. Site. (site_id_l)
#       
#  Random effects are nested: (1|abcd_site/rel_family_id).

#      Fixed effects.
#           1. Race parent. (race.ethnicity.5level).
#           2. Education parent. (high.educ).
#           3. Income parent. (household.income)
#           4. Marital status parent. (married.or.livingtogether)
#           5. Age. (interview_age).
#           6. Hispanic. (demo_race_hispanic).

nrow(fulldata) # 27321 (exploratory); 27331 (confirmatory).
# Because this is such a big data file, let's only keep the columns that we need for this analysis.
data <- fulldata[,c("src_subject_id",
                    "interview_age",
                    "eventname",
                    "sex",
                    "site_id_l",
                    "mri_info_deviceserialnumber",
                    "rel_family_id",
                    "race.ethnicity.5level",
                    "race.eth.7level",
                    "demo_race_hispanic", # Do you consider the child Hispanic/Latino/Latina?
                    "high.educ",
                    "household.income",
                    "married.or.livingtogether",
                    "cbcl_scr_syn_internal_t",
                    "cbcl_scr_syn_anxdep_t",
                    "cbcl_scr_syn_withdep_t",
                    "cbcl_scr_dsm5_depress_t",
                    "cbcl_scr_dsm5_anxdisord_t",
                    "cbcl_scr_syn_internal_r",
                    "cbcl_scr_syn_anxdep_r",
                    "cbcl_scr_syn_withdep_r",
                    "cbcl_scr_dsm5_depress_r",
                    "cbcl_scr_dsm5_anxdisord_r",
                    #"PDS_score_f",
                    #"PDS_score_m",
                    "PDS_score",
                    #"PDS_sum_f",
                    #"PDS_sum_m",
                    #"PDS_sum",
                    #"pds_p_ss_category",
                    "pds_ss_category",
                    "fam_history_q6d_depression",
                    "tfmri_ma_acdn_b_scs_aarh", # Accumbens reward vs. neutral anticipation.
                    "tfmri_ma_acdn_b_scs_aalh",
                    "tfmri_ma_acdn_b_scs_cdrh", # Caudate reward vs. neutral anticipation.
                    "tfmri_ma_acdn_b_scs_cdlh",
                    "tfmri_ma_acdn_b_scs_ptrh", # Putamen reward vs. neutral anticipation.
                    "tfmri_ma_acdn_b_scs_ptlh",
                    "tfmri_ma_arvn_b_cds_mobofrrh", # Medial OFC reward vs. neutral anticipation.
                    "tfmri_ma_arvn_b_cds_mobofrlh",
                    "tfmri_ma_arvn_b_cds_lobofrrh", # Lateral OFC reward vs. neutral anticipation.
                    "tfmri_ma_arvn_b_cds_lobofrlh",
                    "tfmri_ma_rpvnfb_b_scs_aarh", # Accumbens reward positive versus negative feedback.
                    "tfmri_ma_rpvnfb_b_scs_aalh",
                    "tfmri_ma_rpvnfb_b_scs_cdrh", # Caudate reward positive versus negative feedback.
                    "tfmri_ma_rpvnfb_b_scs_cdlh",
                    "tfmri_ma_rpvnfb_b_scs_ptrh", # Putamen reward positive versus negative feedback.
                    "tfmri_ma_rpvnfb_b_scs_ptlh",
                    "tfmri_ma_rpvnfb_b_cds_mobofrrh", # Medial OFC reward positive versus negative feedback.
                    "tfmri_ma_rpvnfb_b_cds_mobofrlh",
                    "tfmri_ma_rpvnfb_b_cds_lobofrrh", # Lateral OFC reward positive versus negative feedback.
                    "tfmri_ma_rpvnfb_b_cds_lobofrlh",
                    "accumbens_rvsn_ant_z", # Reward vs. neutral during anticipation stage (z scores).
                    "caudate_rvsn_ant_z",
                    "putamen_rvsn_ant_z",
                    "mOFC_rvsn_ant_z",
                    "lOFC_rvsn_ant_z",
                    "striatum_rvsn_ant_z", # reward vs. neutral anticipation.
                    "accumbens_posvsneg_feedback_z", # All positive vs. negative feedback.
                    "caudate_posvsneg_feedback_z",
                    "putamen_posvsneg_feedback_z",
                    "mOFC_posvsneg_feedback_z",
                    "lOFC_posvsneg_feedback_z",
                    "striatum_posvsneg_feedback_z",
                    "bisbas_ss_basm_rr",
                    "hormone_scr_ert_mean",
                    "hormone_scr_dhea_mean",
                    "tfmri_mid_all_beh_large.reward.pos.feedback_mean.rt", #Average MID RT Large Reward Positive
                    "tfmri_mid_all_beh_small.reward.pos.feedback_mean.rt", #Average MID RT Small Reward Positive
                    "tfmri_mid_all_beh_neutral.pos.feedback_mean.rt",#Average MID RT Neutral Positive
                    "tfmri_mid_beh_performflag", # Exclude or include based on MID behavioral data (1 = good; 0 = exclude).
                    #  0    1 NA's 
                    # 288 4250 1397
                    "imgincl_mid_include", # Exclude or include based on neuroimaging data (1 = good; 0 = exclude).
                    "hormone_sal_sex",
                    "hormon_sal_notes_y___1",
                    "hormon_sal_notes_y___2",
                    "hormon_sal_notes_y___3",
                    "hormon_sal_notes_y___4",
                    "hormon_sal_notes_y___5",
                    "hormon_sal_notes_y___6",
                    "hormone_scr_dhea_rep1",
                    "hormone_scr_dhea_rep2",
                    "hormone_scr_dhea_rep1_nd",
                    "hormone_scr_dhea_rep2_nd",
                    "hormone_scr_ert_rep1",
                    "hormone_scr_ert_rep2",
                    "hormone_scr_ert_rep1_nd",
                    "hormone_scr_ert_rep2_nd",
                    "hormone_scr_hse_rep1",
                    "hormone_scr_hse_rep2",
                    "hormone_scr_hse_rep1_nd",
                    "hormone_scr_hse_rep2_nd",
                    "anthroweightcalc",
                    "anthroheightcalc",
                    "hormone_sal_start_y", # Hormone saliva sample time collection started.
                    "hormone_sal_end_y", # Hormone saliva sample time collection finished.
                    "iqc_mid_study_date", # Date of first MID imaging series.
                    "iqc_mid_series_time", # Time of first MID imaging series.
                    "iqc_mid_series_date_time", # iqc_mid_study_date + iqc_mid_series_time
                    "menstrualcycle1_p", #  What was the date of the first day of your child's last period?
                    "interview_date_hormones", # the 'interview_date' column specifically from hormone file (sph01.txt), renamed for clarity.
                    "hormone_date_time", # interview_date_hormones + hormone_sal_end_y
                    "MRI_minus_hormone_date_time", # iqc_mid_series_date_time - hormone_date_time [date/time variables]
                    "hormone_date_minus_last_period_date", #interview_date_hormones - menstrualcylcle1_p [dates only, no times added]
                    "hormone_sal_end_min_since_midnight")] # hormone_sal_start_y, converted to time in minutes since midnight.


# Note: pds_ss_category = pds_p_ss_category. Rename here.
data <- rename(data, pds_p_ss_category = pds_ss_category)

data[c("src_subject_id","rel_family_id","eventname",
       "sex","demo_race_hispanic","site_id_l",
       "mri_info_deviceserialnumber","race.ethnicity.5level","race.eth.7level",
       "high.educ","household.income","married.or.livingtogether",
       "pds_p_ss_category","tfmri_mid_beh_performflag","imgincl_mid_include")] <- lapply(data[c("src_subject_id","rel_family_id","eventname",
                                                                                                "sex","demo_race_hispanic","site_id_l",
                                                                                                "mri_info_deviceserialnumber","race.ethnicity.5level","race.eth.7level",
                                                                                                "high.educ","household.income","married.or.livingtogether",
                                                                                              "pds_p_ss_category","tfmri_mid_beh_performflag","imgincl_mid_include")], as.factor)

# Releveling so that "Pre" is the reference group for PDS category.
data$pds_p_ss_category <- relevel(data$pds_p_ss_category, ref="Pre")

#data$race.ethnicity.5level = data$race.eth.7level
#data$race.ethnicity.5level[(data$race.eth.7level == "AIAN" | data$race.eth.7level == "NHPI")] = "Other"
#data$race.ethnicity.5level = droplevels(data$race.ethnicity.5level)

# Exclude two participants who have multiple rows for baseline.
data <- subset(data, src_subject_id != "NDAR_INV2ZA2LC3N" & src_subject_id != "NDAR_INVJ9GNXGK5")
nrow(data) # 27298.

# Use only data from baseline.
data <- subset(data,eventname == "baseline_year_1_arm_1")
nrow(data) # 5945 (exploratory).

data$PDS_score_z<- scale(data$PDS_score)
data$cbcl_scr_syn_internal_r_z <- scale(data$cbcl_scr_syn_internal_r)

# Lines 148 to 223 filter invalid testosterone values (Adapted from Herting script).

# Exploratory.
# 5 Female with misclassified Male tubes. 6 Male with misclassified Female tubes. 49 either had issues at saliva collection or had NA gender values.
# Let's get rid of them. We go down from  5905 -> 5691 (-56).

table(data$sex, data$hormone_sal_sex)

data  <- data[-c(which(data$sex == "M" & data$hormone_sal_sex == 1), 
             which(data$sex =="F" & data$hormone_hormone_sal_sex == 2),
             which(data$hormone_sal_sex == 3),
             which(data$hormone_sal_sex == 4),
             which(data$hormone_sal_sex == 5),
             which(is.na(data$sex)),
             which(is.na(data$hormone_sal_sex))),]

###################### NDA --- DEAP
# hormone_sal_sex       1       Pink (female)
# hormone_sal_sex       2       Blue (male)
# hormone_sal_sex       3       Participant unable to complete
# hormone_sal_sex       4       Participant/Parent refused
# hormone_sal_sex       5       Not collected (other)      


#Let's filter the data
#The filter scheme is to check records for any RA saliva collection notes. If true, then flag the record. 
#Then check flagged records and see if the Salimetrics value is out of range per hormone.
#If yes, then change value to NA, else keep the existing values for each replicate.
#Finally, average the two replicates into a new field.
data$hormone_notes_ss <- as.numeric(data$hormon_sal_notes_y___2) + 
  as.numeric(data$hormon_sal_notes_y___3) +
  as.numeric(data$hormon_sal_notes_y___4) + 
  as.numeric(data$hormon_sal_notes_y___5) + 
  as.numeric(data$hormon_sal_notes_y___6)
rownums <- which(data$hormone_notes_ss > 1)

#Filter out wonky values
#DHEA
data$filtered_dhea <- NA
data$filtered_dhea_rep1 <- as.numeric(data$hormone_scr_dhea_rep1)
data$filtered_dhea_rep2 <- data$hormone_scr_dhea_rep2
data$filtered_dhea[which(data$hormone_scr_dhea_rep1_nd == 1)] <- 0
data$filtered_dhea[which(data$hormone_scr_dhea_rep2_nd == 1)] <- 0
rownums_rep1 <- which(data$hormone_scr_dhea_rep1 < 5 | data$hormone_scr_dhea_rep1 > 1000)
rownums_rep2 <- which(data$hormone_scr_dhea_rep2 < 5 | data$hormone_scr_dhea_rep2 > 1000)
data$filtered_dhea_rep1[rownums[which(rownums %in% rownums_rep1)]] <- NA
data$filtered_dhea_rep2[rownums[which(rownums %in% rownums_rep2)]] <- NA
data$filtered_dhea <- apply(data[, c("filtered_dhea_rep1", "filtered_dhea_rep2")], 1, function(x) mean(x, na.rm=T))

#Testosterone
data$filtered_testosterone <- NA
data$filtered_testosterone_rep1 <- data$hormone_scr_ert_rep1
data$filtered_testosterone_rep2 <- data$hormone_scr_ert_rep2
data$filtered_testosterone[which(data$hormone_scr_ert_rep1_nd == 1)] <- 0
data$filtered_testosterone[which(data$hormone_scr_ert_rep2_nd == 1)] <- 0
rownums_rep1 <- which(data$hormone_scr_ert_rep1 < 1 | data$hormone_scr_ert_rep1 > 600)
rownums_rep2 <- which(data$hormone_scr_ert_rep2 < 1 | data$hormone_scr_ert_rep2 > 600)
data$filtered_testosterone_rep1[rownums[which(rownums %in% rownums_rep1)]] <- NA
data$filtered_testosterone_rep2[rownums[which(rownums %in% rownums_rep2)]] <- NA
data$filtered_testosterone <- apply(data[, c("filtered_testosterone_rep1", "filtered_testosterone_rep2")], 1, function(x) mean(x, na.rm=T))

#Estradiol
data$filtered_estradiol <- NA
data$filtered_estradiol_rep1 <- data$hormone_scr_hse_rep1
data$filtered_estradiol_rep2 <- data$hormone_scr_hse_rep2
data$filtered_estradiol[which(data$hormone_scr_hse_rep1_nd == 1)] <- 0
data$filtered_estradiol[which(data$hormone_scr_hse_rep2_nd == 1)] <- 0
rownums_rep1 <- which(data$hormone_scr_hse_rep1 < 0.1 | data$hormone_scr_hse_rep1 > 32)
rownums_rep2 <- which(data$hormone_scr_hse_rep2 < 0.1 | data$hormone_scr_hse_rep2 > 32)
data$filtered_estradiol_rep1[rownums[which(rownums %in% rownums_rep1)]] <- NA
data$filtered_estradiol_rep2[rownums[which(rownums %in% rownums_rep2)]] <- NA
data$filtered_estradiol <- apply(data[, c("filtered_estradiol_rep1", "filtered_estradiol_rep2")], 1, function(x) mean(x, na.rm=T))

#Scale hormone data
data$hormone_scr_ert_mean_z <- scale(data$filtered_testosterone)  #852 outliers in Total sample
data$hormone_estradiol_z <- scale(data$filtered_estradiol) #996 outliers just to have
data$hormone_dhea_z <- scale(data$filtered_dhea) #832 outliers  #just to have

# Use data with only correct PDS scores.
# This also removes any rows with NA values in PDS_score.
PDS_correct <- subset(data, PDS_score < 5) #Be mindful that PDS category goes from 1 to 5, while PDS_score goes from 1 to 4 (continuous).
nrow(PDS_correct) # 5738 (exploratory).

#PDS_correct <- subset(PDS_correct, PDS_sum < 30) # This shouldn't change anything but just in case there is somehow a participant with a PDS score less than 5 but a sum that is incorrect.
#nrow(PDS_correct) # Exploratory: 4224. Confirmatory: 4244.
#PDS_correct <- PDS_correct %>% filter(sex!="") #remove 6 participants with no gender.
#nrow(PDS_correct) # Exploratory: 4224. Confirmatory: 4244. Were these participants already removed from the dataframe?

# There are two people with a PDS category score of 5 ("post"), which will bias the category estimates a lot, so we are removing them.
# post_pubertal <- subset(PDS_correct, pds_p_ss_category == "Post")
# nrow(post_pubertal) # Seven participants in exploratory.
PDS_correct <- subset(PDS_correct, pds_p_ss_category != "Post")
nrow(PDS_correct) # 5683.
mean_PDS_score <- mean(PDS_correct$PDS_score)
sd_PDS_score <- sd(PDS_correct$PDS_score)
PDS_correct$PDS_score_z <- (PDS_correct$PDS_score-mean_PDS_score)/sd_PDS_score 

# Exclude based on ABCD's recommendation for MID imaging, including only those with both usable task and imaging data here.
# Start with neuroimaging flag (exclude people ABCD says to exclude based on MID imaging data).
summary(PDS_correct$imgincl_mid_include)
# 0    1      NA's
# 1450 4191   42
# nrow(MID_task_correct)
# 1450 + 42 = 1492.


# Calculate BMI variable
PDS_correct$bmi <- 703*(PDS_correct$anthroweightcalc/(PDS_correct$anthroheightcalc^2))
#Filtering BMI values based on the possible range from the CDC Growth Chart
PDS_correct$bmi <- ifelse(PDS_correct$bmi >= 12, ifelse(PDS_correct$bmi <= 35, PDS_correct$bmi, NA), NA)

# Get z scores for bis bas rr scores.
mean_bisbas <- mean(PDS_correct$bisbas_ss_basm_rr, na.rm=TRUE)
sd_bisbas <- sd(PDS_correct$bisbas_ss_basm_rr, na.rm=TRUE)
PDS_correct$bisbas_ss_basm_rr_z <- (PDS_correct$bisbas_ss_basm_rr-mean_bisbas)/sd_bisbas

MID_imaging_correct <- subset(PDS_correct, imgincl_mid_include ==1) 
nrow(MID_imaging_correct) # 4191 (exploratory). So 1492 drop out after imaging parameters are taken into account.

# Next, use behavioral task flag to also exclude people ABCD says to exclude based on MID task data.
MID_imaging_correct <- subset(MID_imaging_correct, tfmri_mid_beh_performflag ==1)
nrow(MID_imaging_correct) # 4191 (exploratory). So no extra people drop out based on this behavioral performance flag.
# So this suggests that 'imgincl_mid_include' already takes into account the information from 'tfmri_mid_beh_performflag'.

# Keep a version that is just the task (not based on neuroimaging) for our behavioral analyses.
MID_task_correct <- subset(PDS_correct, tfmri_mid_beh_performflag ==1)
nrow(MID_task_correct) # 4656 (exploratory).
#summary(PDS_correct$tfmri_mid_beh_performflag) # Note: There are many NA values, which result in removing a lot of participants.
#  0    1     NA's 
#  363 4656  664 

# MID Reaction Time Variable Creation  (including here, after MID_task_correct is created, so that when we scale, we are using the data frame that only includes the correct MID task data).
## Reaction time difference between large reward trials and neutral trials (Positive value indicates greater sensitivity to large reward than neutral trials).
MID_task_correct$rt_diff_large_neutral <- MID_task_correct$tfmri_mid_all_beh_neutral.pos.feedback_mean.rt - MID_task_correct$tfmri_mid_all_beh_large.reward.pos.feedback_mean.rt

## Reaction time difference between large reward trials and neutral trials (Positive value indicates greater sensitivity to large reward than small trials)
MID_task_correct$rt_diff_large_small <- MID_task_correct$tfmri_mid_all_beh_small.reward.pos.feedback_mean.rt - MID_task_correct$tfmri_mid_all_beh_large.reward.pos.feedback_mean.rt

MID_task_correct$rt_diff_large_neutral_z <- scale(MID_task_correct$rt_diff_large_neutral)
MID_task_correct$rt_diff_large_small_z <- scale(MID_task_correct$rt_diff_large_small)

# Separate by sex.
PDS_correct_females <- subset(PDS_correct, sex == "F")
PDS_correct_males <- subset(PDS_correct, sex == "M")
nrow(PDS_correct_females)  # 2720 (exploratory).
nrow(PDS_correct_males) # 2963 (exploratory).

MID_task_correct_females <- subset(MID_task_correct, sex == "F")
MID_task_correct_males <- subset(MID_task_correct, sex == "M")
nrow(MID_task_correct_females)  # 2274 (exploratory).
nrow(MID_task_correct_males) # 2382 (exploratory).

MID_imaging_correct_females <- subset(MID_imaging_correct, sex == "F")
MID_imaging_correct_males <- subset(MID_imaging_correct, sex == "M")
nrow(MID_imaging_correct_females)  # 2073 (exploratory).
nrow(MID_imaging_correct_males) # 2118 (exploratory).

# Create different subsets of the data based on removing outliers for specific variables of interest.
# For anything that is not related to the MID task, use PDS_correct.
# For anything that is related to the behavioral data from the MID task (and not the imaging data), use MID_task_correct.
# For anything that is related to the imaging data from the MID task, use MID_imaging_correct.

# No striatal anticipation outliers.
data_no_striatal_ant_outliers <- subset(MID_imaging_correct, striatum_rvsn_ant_z > -3 & striatum_rvsn_ant_z < 3)
nrow(data_no_striatal_ant_outliers) # 4146 (exploratory).

data_no_striatal_ant_outliers_females <- subset(MID_imaging_correct_females, striatum_rvsn_ant_z > -3 & striatum_rvsn_ant_z < 3)
nrow(data_no_striatal_ant_outliers_females) # 2054 (exploratory).

data_no_striatal_ant_outliers_males <- subset(MID_imaging_correct_males, striatum_rvsn_ant_z > -3 & striatum_rvsn_ant_z < 3)
nrow(data_no_striatal_ant_outliers_males) # 2092 (exploratory).

# No striatal FEEDBACK outliers.
data_no_striatal_feed_outliers <- subset(MID_imaging_correct, striatum_posvsneg_feedback_z > -3 & striatum_posvsneg_feedback_z < 3)
nrow(data_no_striatal_feed_outliers) # 4142 (exploratory).

data_no_striatal_feed_outliers_females <- subset(MID_imaging_correct_females, striatum_posvsneg_feedback_z > -3 & striatum_posvsneg_feedback_z < 3)
nrow(data_no_striatal_feed_outliers_females) # 2056 (exploratory).

data_no_striatal_feed_outliers_males <- subset(MID_imaging_correct_males, striatum_posvsneg_feedback_z > -3 & striatum_posvsneg_feedback_z < 3)
nrow(data_no_striatal_feed_outliers_males) # 2086 (exploratory).

# summary(MID_imaging_correct_females$pds_p_ss_category)
# summary(MID_imaging_correct_males$pds_p_ss_category)

data_no_striatal_feed_outliers_females_pubertal <- subset(MID_imaging_correct_females, striatum_posvsneg_feedback_z > -3 & striatum_posvsneg_feedback_z < 3  & pds_p_ss_category != "Pre")
nrow(data_no_striatal_feed_outliers_females_pubertal) # 1399 (exploratory).
data_no_striatal_feed_outliers_males_pubertal <- subset(MID_imaging_correct_males, striatum_posvsneg_feedback_z > -3 & striatum_posvsneg_feedback_z < 3  &  pds_p_ss_category != "Pre")
nrow(data_no_striatal_feed_outliers_males_pubertal) # 611 (exploratory).

data_no_striatal_feed_outliers_females_prepubertal <- subset(MID_imaging_correct_females, striatum_posvsneg_feedback_z > -3 & striatum_posvsneg_feedback_z < 3   & pds_p_ss_category == "Pre")
nrow(data_no_striatal_feed_outliers_females_prepubertal) # 657 (exploratory).
data_no_striatal_feed_outliers_males_prepubertal <- subset(MID_imaging_correct_males, striatum_posvsneg_feedback_z > -3 & striatum_posvsneg_feedback_z < 3   &  pds_p_ss_category == "Pre")
nrow(data_no_striatal_feed_outliers_males_prepubertal) # 1475 (exploratory).

# No lateral OFC (lOFC) anticipation outliers.
data_no_lOFC_ant_outliers <- subset(MID_imaging_correct, lOFC_rvsn_ant_z > -3 & lOFC_rvsn_ant_z < 3)
nrow(data_no_lOFC_ant_outliers) # 4135 (exploratory).

data_no_lOFC_ant_outliers_females <- subset(MID_imaging_correct_females, lOFC_rvsn_ant_z > -3 & lOFC_rvsn_ant_z < 3)
nrow(data_no_lOFC_ant_outliers_females) # 2050 (exploratory).

data_no_lOFC_ant_outliers_males <- subset(MID_imaging_correct_males, lOFC_rvsn_ant_z > -3 & lOFC_rvsn_ant_z < 3)
nrow(data_no_lOFC_ant_outliers_males) # 2085 (exploratory).

data_no_lOFC_ant_outliers_females_pubertal <- subset(MID_imaging_correct_females, lOFC_rvsn_ant_z > -3 & lOFC_rvsn_ant_z < 3 & pds_p_ss_category != "Pre")
nrow(data_no_lOFC_ant_outliers_females_pubertal) # 2050 (exploratory).
data_no_lOFC_ant_outliers_males_pubertal <- subset(MID_imaging_correct_males, lOFC_rvsn_ant_z > -3 & lOFC_rvsn_ant_z < 3 &  pds_p_ss_category != "Pre")
nrow(data_no_lOFC_ant_outliers_males_pubertal) # 603 (exploratory).

data_no_lOFC_ant_outliers_females_prepubertal <- subset(MID_imaging_correct_females, lOFC_rvsn_ant_z > -3 & lOFC_rvsn_ant_z < 3 & pds_p_ss_category == "Pre")
nrow(data_no_lOFC_ant_outliers_females_prepubertal) # 658 (exploratory).
data_no_lOFC_ant_outliers_males_prepubertal <- subset(MID_imaging_correct_males, lOFC_rvsn_ant_z > -3 & lOFC_rvsn_ant_z < 3 &  pds_p_ss_category == "Pre")
nrow(data_no_lOFC_ant_outliers_males_prepubertal) # 1482 (exploratory).

# No medial OFC (mOFC) anticipation outliers.
data_no_mOFC_ant_outliers <- subset(MID_imaging_correct, mOFC_rvsn_ant_z > -3 & mOFC_rvsn_ant_z < 3)
nrow(data_no_mOFC_ant_outliers) # 4130 (exploratory).

data_no_mOFC_ant_outliers_females <- subset(MID_imaging_correct_females, mOFC_rvsn_ant_z > -3 & mOFC_rvsn_ant_z < 3)
nrow(data_no_mOFC_ant_outliers_females) # 2051 (exploratory).

data_no_mOFC_ant_outliers_males <- subset(MID_imaging_correct_males, mOFC_rvsn_ant_z > -3 & mOFC_rvsn_ant_z < 3)
nrow(data_no_mOFC_ant_outliers_males) # 2079 (exploratory).

data_no_mOFC_ant_outliers_females_pubertal <- subset(MID_imaging_correct_females, mOFC_rvsn_ant_z > -3 & mOFC_rvsn_ant_z < 3 & pds_p_ss_category != "Pre")
nrow(data_no_mOFC_ant_outliers_females_pubertal) # 1392 (exploratory).
data_no_mOFC_ant_outliers_males_pubertal <- subset(MID_imaging_correct_males, mOFC_rvsn_ant_z > -3 & mOFC_rvsn_ant_z < 3 &  pds_p_ss_category != "Pre")
nrow(data_no_mOFC_ant_outliers_males_pubertal) # 607 (exploratory).

data_no_mOFC_ant_outliers_females_prepubertal <- subset(MID_imaging_correct_females, mOFC_rvsn_ant_z > -3 & mOFC_rvsn_ant_z < 3 & pds_p_ss_category == "Pre")
nrow(data_no_mOFC_ant_outliers_females_prepubertal) # 659 (exploratory).
data_no_mOFC_ant_outliers_males_prepubertal <- subset(MID_imaging_correct_males, mOFC_rvsn_ant_z > -3 & mOFC_rvsn_ant_z < 3 &  pds_p_ss_category == "Pre")
nrow(data_no_mOFC_ant_outliers_males_prepubertal) # 1472 (exploratory).

# No lateral OFC (lOFC) FEEDBACK outliers.
data_no_lOFC_feed_outliers <- subset(MID_imaging_correct, lOFC_posvsneg_feedback_z > -3 & lOFC_posvsneg_feedback_z < 3)
nrow(data_no_lOFC_feed_outliers) # 4147 (exploratory).

data_no_lOFC_feed_outliers_females <- subset(MID_imaging_correct_females, lOFC_posvsneg_feedback_z > -3 & lOFC_posvsneg_feedback_z < 3)
nrow(data_no_lOFC_feed_outliers_females) # 2052 (exploratory).

data_no_lOFC_feed_outliers_males <- subset(MID_imaging_correct_males, lOFC_posvsneg_feedback_z > -3 & lOFC_posvsneg_feedback_z < 3)
nrow(data_no_lOFC_feed_outliers_males) # 2095 (exploratory).

data_no_lOFC_feed_outliers_females_pubertal <- subset(MID_imaging_correct_females, lOFC_posvsneg_feedback_z > -3 & lOFC_posvsneg_feedback_z < 3 & pds_p_ss_category != "Pre")
nrow(data_no_lOFC_feed_outliers_females_pubertal) # 1391 (exploratory).
data_no_lOFC_feed_outliers_males_pubertal <- subset(MID_imaging_correct_males, lOFC_posvsneg_feedback_z > -3 & lOFC_posvsneg_feedback_z < 3 &  pds_p_ss_category != "Pre")
nrow(data_no_lOFC_feed_outliers_males_pubertal) # 609 (exploratory).

data_no_lOFC_feed_outliers_females_prepubertal <- subset(MID_imaging_correct_females, lOFC_posvsneg_feedback_z > -3 & lOFC_posvsneg_feedback_z < 3 & pds_p_ss_category == "Pre")
nrow(data_no_lOFC_feed_outliers_females_prepubertal) # 661 (exploratory).
data_no_lOFC_feed_outliers_males_prepubertal <- subset(MID_imaging_correct_males, lOFC_posvsneg_feedback_z > -3 & lOFC_posvsneg_feedback_z < 3 &  pds_p_ss_category == "Pre")
nrow(data_no_lOFC_feed_outliers_males_prepubertal) # 1486 (exploratory).

# No medial OFC (mOFC) FEEDBACK outliers.
data_no_mOFC_feed_outliers <- subset(MID_imaging_correct, mOFC_posvsneg_feedback_z > -3 & mOFC_posvsneg_feedback_z < 3)
nrow(data_no_mOFC_feed_outliers) # 4146 (exploratory).

data_no_mOFC_feed_outliers_females <- subset(MID_imaging_correct_females, mOFC_posvsneg_feedback_z > -3 & mOFC_posvsneg_feedback_z < 3)
nrow(data_no_mOFC_feed_outliers_females) # 2053 (exploratory).

data_no_mOFC_feed_outliers_males <- subset(MID_imaging_correct_males, mOFC_posvsneg_feedback_z > -3 & mOFC_posvsneg_feedback_z < 3)
nrow(data_no_mOFC_feed_outliers_males) # 2093 (exploratory).

data_no_mOFC_feed_outliers_females_pubertal <- subset(MID_imaging_correct_females, mOFC_posvsneg_feedback_z > -3 & mOFC_posvsneg_feedback_z < 3 & pds_p_ss_category != "Pre")
nrow(data_no_mOFC_feed_outliers_females_pubertal) # 1392 (exploratory).
data_no_mOFC_feed_outliers_males_pubertal <- subset(MID_imaging_correct_males, mOFC_posvsneg_feedback_z > -3 & mOFC_posvsneg_feedback_z < 3 &  pds_p_ss_category != "Pre")
nrow(data_no_mOFC_feed_outliers_males_pubertal) # 613 (exploratory).

data_no_mOFC_feed_outliers_females_prepubertal <- subset(MID_imaging_correct_females, mOFC_posvsneg_feedback_z > -3 & mOFC_posvsneg_feedback_z < 3 & pds_p_ss_category == "Pre")
nrow(data_no_mOFC_feed_outliers_females_prepubertal) # 661 (exploratory).
data_no_mOFC_feed_outliers_males_prepubertal <- subset(MID_imaging_correct_males, mOFC_posvsneg_feedback_z > -3 & mOFC_posvsneg_feedback_z < 3 &  pds_p_ss_category == "Pre")
nrow(data_no_mOFC_feed_outliers_males_prepubertal) # 1480 (exploratory).

# No testosterone outliers.
data_no_test_outliers <- subset(PDS_correct, hormone_scr_ert_mean_z > -3 & hormone_scr_ert_mean_z < 3)
data_no_test_outliers_females <- subset(PDS_correct_females, hormone_scr_ert_mean_z > -3 & hormone_scr_ert_mean_z < 3)
data_no_test_outliers_males <- subset(PDS_correct_males, hormone_scr_ert_mean_z > -3 & hormone_scr_ert_mean_z < 3)

data_no_bisbas_outliers <- subset(PDS_correct, bisbas_ss_basm_rr_z > -3 & bisbas_ss_basm_rr_z < 3)
nrow(data_no_bisbas_outliers) # 5654 (exploratory).
data_no_bisbas_outliers_females <- subset(data_no_bisbas_outliers, sex == "F")
nrow(data_no_bisbas_outliers_females) # 2709 (exploratory).
data_no_bisbas_outliers_males <- subset(data_no_bisbas_outliers, sex == "M")
nrow(data_no_bisbas_outliers_males) # 2945 (exploratory).

# No striatal anticipation or testosterone outliers.
data_no_striatal_ant_test_outliers <- subset(data_no_striatal_ant_outliers, hormone_scr_ert_mean_z > -3 & hormone_scr_ert_mean_z < 3)
data_no_striatal_ant_test_outliers_females <- subset(data_no_striatal_ant_outliers_females, hormone_scr_ert_mean_z > -3 & hormone_scr_ert_mean_z < 3)
data_no_striatal_ant_test_outliers_males <- subset(data_no_striatal_ant_outliers_males, hormone_scr_ert_mean_z > -3 & hormone_scr_ert_mean_z < 3)

# No striatal feedback or testosterone outliers.
data_no_striatal_feed_test_outliers <- subset(data_no_striatal_feed_outliers, hormone_scr_ert_mean_z > -3 & hormone_scr_ert_mean_z < 3)
data_no_striatal_feed_test_outliers_females <- subset(data_no_striatal_feed_outliers_females, hormone_scr_ert_mean_z > -3 & hormone_scr_ert_mean_z < 3)
data_no_striatal_feed_test_outliers_males <- subset(data_no_striatal_feed_outliers_males, hormone_scr_ert_mean_z > -3 & hormone_scr_ert_mean_z < 3)

# No lOFC anticipation or testosterone outliers.
data_no_lOFC_ant_test_outliers <- subset(data_no_lOFC_ant_outliers, hormone_scr_ert_mean_z > -3 & hormone_scr_ert_mean_z < 3)
data_no_lOFC_ant_test_outliers_females <- subset(data_no_lOFC_ant_outliers_females, hormone_scr_ert_mean_z > -3 & hormone_scr_ert_mean_z < 3)
data_no_lOFC_ant_test_outliers_males <- subset(data_no_lOFC_ant_outliers_males, hormone_scr_ert_mean_z > -3 & hormone_scr_ert_mean_z < 3)

# No lOFC feedback or testosterone outliers.
data_no_lOFC_feed_test_outliers <- subset(data_no_lOFC_feed_outliers, hormone_scr_ert_mean_z > -3 & hormone_scr_ert_mean_z < 3)
data_no_lOFC_feed_test_outliers_females <- subset(data_no_lOFC_feed_outliers_females, hormone_scr_ert_mean_z > -3 & hormone_scr_ert_mean_z < 3)
data_no_lOFC_feed_test_outliers_males <- subset(data_no_lOFC_feed_outliers_males, hormone_scr_ert_mean_z > -3 & hormone_scr_ert_mean_z < 3)

# No mOFC anticipation or testosterone outliers.
data_no_mOFC_ant_test_outliers <- subset(data_no_mOFC_ant_outliers, hormone_scr_ert_mean_z > -3 & hormone_scr_ert_mean_z < 3)
data_no_mOFC_ant_test_outliers_females <- subset(data_no_mOFC_ant_outliers_females, hormone_scr_ert_mean_z > -3 & hormone_scr_ert_mean_z < 3)
data_no_mOFC_ant_test_outliers_males <- subset(data_no_mOFC_ant_outliers_males, hormone_scr_ert_mean_z > -3 & hormone_scr_ert_mean_z < 3)

# No mOFC feedback or testosterone outliers.
data_no_mOFC_feed_test_outliers <- subset(data_no_mOFC_feed_outliers, hormone_scr_ert_mean_z > -3 & hormone_scr_ert_mean_z < 3)
data_no_mOFC_feed_test_outliers_females <- subset(data_no_mOFC_feed_outliers_females, hormone_scr_ert_mean_z > -3 & hormone_scr_ert_mean_z < 3)
data_no_mOFC_feed_test_outliers_males <- subset(data_no_mOFC_feed_outliers_males, hormone_scr_ert_mean_z > -3 & hormone_scr_ert_mean_z < 3)

# No BIS/BAS or testosterone outliers.
data_no_bisbas_test_outliers <- subset(data_no_bisbas_outliers, hormone_scr_ert_mean_z > -3 & hormone_scr_ert_mean_z < 3)
data_no_bisbas_test_outliers_females <- subset(data_no_bisbas_outliers_females, hormone_scr_ert_mean_z > -3 & hormone_scr_ert_mean_z < 3)
data_no_bisbas_test_outliers_males <- subset(data_no_bisbas_outliers_males, hormone_scr_ert_mean_z > -3 & hormone_scr_ert_mean_z < 3)

# No MID Reaction Time outliers.
data_no_RT_MID_outliers_females <- subset(MID_task_correct_females, rt_diff_large_neutral_z > -3 & rt_diff_large_neutral_z < 3 & rt_diff_large_small_z > -3 & rt_diff_large_small_z < 3)
data_no_RT_MID_outliers_males <- subset(MID_task_correct_males, rt_diff_large_neutral_z > -3 & rt_diff_large_neutral_z < 3 & rt_diff_large_small_z > -3 & rt_diff_large_small_z < 3)

# No MID Reaction Time or testosterone outliers.
data_no_RT_test_outliers_females <- subset(data_no_RT_MID_outliers_females, hormone_scr_ert_mean_z > -3 & hormone_scr_ert_mean_z < 3)
data_no_RT_test_outliers_males <- subset(data_no_RT_MID_outliers_males, hormone_scr_ert_mean_z > -3 & hormone_scr_ert_mean_z < 3)

#### Separate reward regions for anticipation reward vs neutral. #### 
# No accumbens outliers.
data_no_accumbens_ant_outliers_females <- subset(MID_imaging_correct_females, accumbens_rvsn_ant_z > -3 & accumbens_rvsn_ant_z < 3)
nrow(data_no_accumbens_ant_outliers_females)
data_no_accumbens_ant_outliers_males <- subset(MID_imaging_correct_males, accumbens_rvsn_ant_z > -3 & accumbens_rvsn_ant_z < 3)
nrow(data_no_accumbens_ant_outliers_males)

# No caudate outliers.
data_no_caudate_ant_outliers_females <- subset(MID_imaging_correct_females, caudate_rvsn_ant_z > -3 & caudate_rvsn_ant_z < 3)
nrow(data_no_caudate_ant_outliers_females) 
data_no_caudate_ant_outliers_males <- subset(MID_imaging_correct_males, caudate_rvsn_ant_z > -3 & caudate_rvsn_ant_z < 3)
nrow(data_no_caudate_ant_outliers_males)

# No putamen outliers.
data_no_putamen_ant_outliers_females <- subset(MID_imaging_correct_females, putamen_rvsn_ant_z > -3 & putamen_rvsn_ant_z < 3)
nrow(data_no_putamen_ant_outliers_females)
data_no_putamen_ant_outliers_males <- subset(MID_imaging_correct_males, putamen_rvsn_ant_z > -3 & putamen_rvsn_ant_z < 3)
nrow(data_no_putamen_ant_outliers_males)

#### Separate reward regions for feedback positive vs negative.####
# No accumbens outliers.
data_no_accumbens_feed_outliers <- subset(MID_imaging_correct, accumbens_posvsneg_feedback_z > -3 & accumbens_posvsneg_feedback_z < 3) 
nrow(data_no_accumbens_feed_outliers)  #4111
data_no_accumbens_feed_outliers_females <- subset(MID_imaging_correct_females, accumbens_posvsneg_feedback_z > -3 & accumbens_posvsneg_feedback_z < 3)
nrow(data_no_accumbens_feed_outliers_females)  #2050
data_no_accumbens_feed_outliers_males <- subset(MID_imaging_correct_males, accumbens_posvsneg_feedback_z > -3 & accumbens_posvsneg_feedback_z < 3)
nrow(data_no_accumbens_feed_outliers_males)    #2061

# No caudate outliers.
data_no_caudate_feed_outliers <- subset(MID_imaging_correct, caudate_posvsneg_feedback_z > -3 & caudate_posvsneg_feedback_z < 3) 
nrow(data_no_caudate_feed_outliers) #4107
data_no_caudate_feed_outliers_females <- subset(MID_imaging_correct_females, caudate_posvsneg_feedback_z > -3 & caudate_posvsneg_feedback_z < 3)
nrow(data_no_caudate_feed_outliers_females)  #2042
data_no_caudate_feed_outliers_males <- subset(MID_imaging_correct_males, caudate_posvsneg_feedback_z > -3 & caudate_posvsneg_feedback_z < 3)
nrow(data_no_caudate_feed_outliers_males)  #2065

# No putamen outliers.
data_no_putamen_feed_outliers <- subset(MID_imaging_correct, putamen_posvsneg_feedback_z > -3 & putamen_posvsneg_feedback_z < 3) 
nrow(data_no_putamen_feed_outliers) #4110
data_no_putamen_feed_outliers_females <- subset(MID_imaging_correct_females, putamen_posvsneg_feedback_z > -3 & putamen_posvsneg_feedback_z < 3)
nrow(data_no_putamen_feed_outliers_females)  #2042
data_no_putamen_feed_outliers_males <- subset(MID_imaging_correct_males, putamen_posvsneg_feedback_z > -3 & putamen_posvsneg_feedback_z < 3)
nrow(data_no_putamen_feed_outliers_males)  #2068

#No reward and no testosterone outliers
#### Separate reward regions for anticipation reward vs neutral. #### 
# No accumbens outliers.
data_no_accumbens_ant_no_test_outliers_females <- subset(MID_imaging_correct_females, accumbens_rvsn_ant_z > -3 & accumbens_rvsn_ant_z < 3 & hormone_scr_ert_mean_z > -3 & hormone_scr_ert_mean_z < 3 )
nrow(data_no_accumbens_ant_no_test_outliers_females)  #1915
data_no_accumbens_ant_no_test_outliers_males <- subset(MID_imaging_correct_males, accumbens_rvsn_ant_z > -3 & accumbens_rvsn_ant_z < 3 & hormone_scr_ert_mean_z > -3 & hormone_scr_ert_mean_z < 3 )
nrow(data_no_accumbens_ant_no_test_outliers_males)

# No caudate outliers.
data_no_caudate_ant_no_test_outliers_females <- subset(MID_imaging_correct_females, caudate_rvsn_ant_z > -3 & caudate_rvsn_ant_z < 3 & hormone_scr_ert_mean_z > -3 & hormone_scr_ert_mean_z < 3 )
nrow(data_no_caudate_ant_no_test_outliers_females) #1914
data_no_caudate_ant_no_test_outliers_males <- subset(MID_imaging_correct_males, caudate_rvsn_ant_z > -3 & caudate_rvsn_ant_z < 3 & hormone_scr_ert_mean_z > -3 & hormone_scr_ert_mean_z < 3)
nrow(data_no_caudate_ant_no_test_outliers_males) #1912

# No putamen outliers.
data_no_putamen_ant_no_test_outliers_females <- subset(MID_imaging_correct_females, putamen_rvsn_ant_z > -3 & putamen_rvsn_ant_z < 3 & hormone_scr_ert_mean_z > -3 & hormone_scr_ert_mean_z < 3)
nrow(data_no_putamen_ant_no_test_outliers_females) #2041 -- > 1912
data_no_putamen_ant_no_test_outliers_males <- subset(MID_imaging_correct_males, putamen_rvsn_ant_z > -3 & putamen_rvsn_ant_z < 3 & hormone_scr_ert_mean_z > -3 & hormone_scr_ert_mean_z < 3)
nrow(data_no_putamen_ant_no_test_outliers_males) #1912

#No reward and no testosterone outliers
#### Separate reward regions for feedback pos vs neg. #### 
# No accumbens outliers.
data_no_accumbens_feed_no_test_outliers <- subset(MID_imaging_correct, accumbens_posvsneg_feedback_z > -3 & accumbens_posvsneg_feedback_z < 3 & hormone_scr_ert_mean_z > -3 & hormone_scr_ert_mean_z < 3) 
nrow(data_no_accumbens_feed_no_test_outliers) #3827
data_no_accumbens_feed_no_test_outliers_females <- subset(MID_imaging_correct_females, accumbens_posvsneg_feedback_z > -3 & accumbens_posvsneg_feedback_z < 3 & hormone_scr_ert_mean_z > -3 & hormone_scr_ert_mean_z < 3)
nrow(data_no_accumbens_feed_no_test_outliers_females) #1918
data_no_accumbens_feed_no_test_outliers_males <- subset(MID_imaging_correct_males, accumbens_posvsneg_feedback_z > -3 & accumbens_posvsneg_feedback_z < 3 & hormone_scr_ert_mean_z > -3 & hormone_scr_ert_mean_z < 3)
nrow(data_no_accumbens_feed_no_test_outliers_males) #1909

# No caudate outliers.
data_no_caudate_feed_no_test_outliers <- subset(MID_imaging_correct, caudate_posvsneg_feedback_z > -3 & caudate_posvsneg_feedback_z < 3 & hormone_scr_ert_mean_z > -3 & hormone_scr_ert_mean_z < 3) 
nrow(data_no_caudate_feed_no_test_outliers) #3823
data_no_caudate_feed_no_test_outliers_females <- subset(MID_imaging_correct_females, caudate_posvsneg_feedback_z > -3 & caudate_posvsneg_feedback_z < 3 & hormone_scr_ert_mean_z > -3 & hormone_scr_ert_mean_z < 3)
nrow(data_no_caudate_feed_no_test_outliers_females)  #1910
data_no_caudate_feed_no_test_outliers_males <- subset(MID_imaging_correct_males, caudate_posvsneg_feedback_z > -3 & caudate_posvsneg_feedback_z < 3 & hormone_scr_ert_mean_z > -3 & hormone_scr_ert_mean_z < 3)
nrow(data_no_caudate_feed_no_test_outliers_males) #1913

# No putamen outliers.
data_no_putamen_feed_no_test_outliers <- subset(MID_imaging_correct, putamen_posvsneg_feedback_z > -3 & putamen_posvsneg_feedback_z < 3 & hormone_scr_ert_mean_z > -3 & hormone_scr_ert_mean_z < 3) 
nrow(data_no_putamen_feed_no_test_outliers) #Total 4110    #Exploratory 3838
data_no_putamen_feed_no_test_outliers_females <- subset(MID_imaging_correct_females, putamen_posvsneg_feedback_z > -3 & putamen_posvsneg_feedback_z < 3 & hormone_scr_ert_mean_z > -3 & hormone_scr_ert_mean_z < 3)
nrow(data_no_putamen_feed_no_test_outliers_females)   #Exploratory 1911
data_no_putamen_feed_outliers_no_test_males <- subset(MID_imaging_correct_males, putamen_posvsneg_feedback_z > -3 & putamen_posvsneg_feedback_z < 3 & hormone_scr_ert_mean_z > -3 & hormone_scr_ert_mean_z < 3)
nrow(data_no_putamen_feed_outliers_no_test_males)   #Exploratory 1917



#### Note: We are including all CBCL values (as long as they are in a reasonable range, i.e., possible given the scale). Not excluding CBCL outliers. #### 
# No CBCL outliers.
#data_no_CBCL_outliers <- subset(PDS_correct, cbcl_scr_syn_internal_r_z > -3 & cbcl_scr_syn_internal_r_z < 3)
#nrow(data_no_CBCL_outliers) # 4152.
#cbcl_outliers <- subset(PDS_correct, cbcl_scr_syn_internal_r_z < -3 | cbcl_scr_syn_internal_r_z > 3)

#data_no_CBCL_outliers_females<- subset(PDS_correct_females, cbcl_scr_syn_internal_r_z > -3 & cbcl_scr_syn_internal_r_z < 3)
#nrow(data_no_CBCL_outliers_females) # 2026.

#data_no_CBCL_outliers_males<- subset(PDS_correct_males, cbcl_scr_syn_internal_r_z > -3 & cbcl_scr_syn_internal_r_z < 3)
#nrow(data_no_CBCL_outliers_males) # 2126.
# 
# 
# # No CBCL or striatal anticipation outliers.
# data_no_CBCL_striatal_ant_outliers <- subset(PDS_correct, striatum_rvsn_ant_z > -3 & striatum_rvsn_ant_z < 3 & cbcl_scr_syn_internal_r_z > -3 & cbcl_scr_syn_internal_r_z < 3)
# nrow(data_no_CBCL_striatal_ant_outliers) # 4097.
# 
# data_no_CBCL_striatal_ant_outliers_females <- subset(PDS_correct_females, striatum_rvsn_ant_z > -3 & striatum_rvsn_ant_z < 3 & cbcl_scr_syn_internal_r_z > -3 & cbcl_scr_syn_internal_r_z < 3)
# nrow(data_no_CBCL_striatal_ant_outliers_females) # 2002.
# 
# data_no_CBCL_striatal_ant_outliers_males <- subset(PDS_correct_males, striatum_rvsn_ant_z > -3 & striatum_rvsn_ant_z < 3 & cbcl_scr_syn_internal_r_z > -3 & cbcl_scr_syn_internal_r_z < 3)
# nrow(data_no_CBCL_striatal_ant_outliers_males) # 2095.
# 
# data_no_CBCL_striatal_ant_outliers_females_pubertal <- subset(PDS_correct_females, striatum_rvsn_ant_z > -3 & striatum_rvsn_ant_z < 3 & cbcl_scr_syn_internal_r_z > -3 & cbcl_scr_syn_internal_r_z < 3 & pds_p_ss_category != "Pre")
# nrow(data_no_CBCL_striatal_ant_outliers_females_pubertal) #1380
# data_no_CBCL_striatal_ant_outliers_males_pubertal <- subset(PDS_correct_males, striatum_rvsn_ant_z > -3 & striatum_rvsn_ant_z < 3 & cbcl_scr_syn_internal_r_z > -3 & cbcl_scr_syn_internal_r_z < 3 &  pds_p_ss_category != "Pre")
# nrow(data_no_CBCL_striatal_ant_outliers_males_pubertal) #583
# 
# data_no_CBCL_striatal_ant_outliers_females_prepubertal <- subset(PDS_correct_females, striatum_rvsn_ant_z > -3 & striatum_rvsn_ant_z < 3 & cbcl_scr_syn_internal_r_z > -3 & cbcl_scr_syn_internal_r_z < 3 & pds_p_ss_category == "Pre")
# nrow(data_no_CBCL_striatal_ant_outliers_females_prepubertal) #1380
# data_no_CBCL_striatal_ant_outliers_males_prepubertal <- subset(PDS_correct_males, striatum_rvsn_ant_z > -3 & striatum_rvsn_ant_z < 3 & cbcl_scr_syn_internal_r_z > -3 & cbcl_scr_syn_internal_r_z < 3 &  pds_p_ss_category == "Pre")
# nrow(data_no_CBCL_striatal_ant_outliers_males_prepubertal) #583
# 
# 
# # No CBCL or striatal FEEDBACK outliers.
# data_no_CBCL_striatal_feed_outliers <- subset(PDS_correct, striatum_posvsneg_feedback_z > -3 & striatum_posvsneg_feedback_z < 3 & cbcl_scr_syn_internal_r_z > -3 & cbcl_scr_syn_internal_r_z < 3)
# nrow(data_no_CBCL_striatal_feed_outliers) # 4109
# 
# data_no_CBCL_striatal_feed_outliers_females <- subset(PDS_correct_females, striatum_posvsneg_feedback_z > -3 & striatum_posvsneg_feedback_z < 3 & cbcl_scr_syn_internal_r_z > -3 & cbcl_scr_syn_internal_r_z < 3)
# nrow(data_no_CBCL_striatal_feed_outliers_females) # 2008.
# 
# data_no_CBCL_striatal_feed_outliers_males <- subset(PDS_correct_males, striatum_posvsneg_feedback_z > -3 & striatum_posvsneg_feedback_z < 3 & cbcl_scr_syn_internal_r_z > -3 & cbcl_scr_syn_internal_r_z < 3)
# nrow(data_no_CBCL_striatal_feed_outliers_males) # 2101.
# 
# data_no_CBCL_striatal_feed_outliers_females_pubertal <- subset(PDS_correct_females, striatum_posvsneg_feedback_z > -3 & striatum_posvsneg_feedback_z < 3 & cbcl_scr_syn_internal_r_z > -3 & cbcl_scr_syn_internal_r_z < 3 & pds_p_ss_category != "Pre")
# nrow(data_no_CBCL_striatal_feed_outliers_females_pubertal) #1385
# data_no_CBCL_striatal_feed_outliers_males_pubertal <- subset(PDS_correct_males, striatum_posvsneg_feedback_z > -3 & striatum_posvsneg_feedback_z < 3 & cbcl_scr_syn_internal_r_z > -3 & cbcl_scr_syn_internal_r_z < 3 &  pds_p_ss_category != "Pre")
# nrow(data_no_CBCL_striatal_feed_outliers_males_pubertal) #586
# 
# data_no_CBCL_striatal_feed_outliers_females_prepubertal <- subset(PDS_correct_females, striatum_posvsneg_feedback_z > -3 & striatum_posvsneg_feedback_z < 3 & cbcl_scr_syn_internal_r_z > -3 & cbcl_scr_syn_internal_r_z < 3 & pds_p_ss_category == "Pre")
# nrow(data_no_CBCL_striatal_feed_outliers_females_prepubertal) #623
# data_no_CBCL_striatal_feed_outliers_males_prepubertal <- subset(PDS_correct_males, striatum_posvsneg_feedback_z > -3 & striatum_posvsneg_feedback_z < 3 & cbcl_scr_syn_internal_r_z > -3 & cbcl_scr_syn_internal_r_z < 3 &  pds_p_ss_category == "Pre")
# nrow(data_no_CBCL_striatal_feed_outliers_males_prepubertal) #1515
# 
# 
# # No CBCL or or lateral OFC (lOFC) anticipation outliers.
# data_no_CBCL_lOFC_ant_outliers <- subset(PDS_correct, lOFC_rvsn_ant_z > -3 & lOFC_rvsn_ant_z < 3 & cbcl_scr_syn_internal_r_z > -3 & cbcl_scr_syn_internal_r_z < 3)
# nrow(data_no_CBCL_lOFC_ant_outliers) # 4061.
# 
# data_no_CBCL_lOFC_ant_outliers_females <- subset(PDS_correct_females, lOFC_rvsn_ant_z > -3 & lOFC_rvsn_ant_z < 3 & cbcl_scr_syn_internal_r_z > -3 & cbcl_scr_syn_internal_r_z < 3)
# nrow(data_no_CBCL_lOFC_ant_outliers_females) # 1992.
# 
# data_no_CBCL_lOFC_ant_outliers_males <- subset(PDS_correct_males, lOFC_rvsn_ant_z > -3 & lOFC_rvsn_ant_z < 3 & cbcl_scr_syn_internal_r_z > -3 & cbcl_scr_syn_internal_r_z < 3)
# nrow(data_no_CBCL_lOFC_ant_outliers_males) # 2069.
# 
# data_no_CBCL_lOFC_ant_outliers_females_pubertal <- subset(PDS_correct_females, lOFC_rvsn_ant_z > -3 & lOFC_rvsn_ant_z < 3 & cbcl_scr_syn_internal_r_z > -3 & cbcl_scr_syn_internal_r_z < 3 & pds_p_ss_category != "Pre")
# nrow(data_no_CBCL_lOFC_ant_outliers_females_pubertal) #1373
# data_no_CBCL_lOFC_ant_outliers_males_pubertal <- subset(PDS_correct_males, lOFC_rvsn_ant_z > -3 & lOFC_rvsn_ant_z < 3 & cbcl_scr_syn_internal_r_z > -3 & cbcl_scr_syn_internal_r_z < 3 &  pds_p_ss_category != "Pre")
# nrow(data_no_CBCL_lOFC_ant_outliers_males_pubertal) #568
# 
# data_no_CBCL_lOFC_ant_outliers_females_prepubertal <- subset(PDS_correct_females, lOFC_rvsn_ant_z > -3 & lOFC_rvsn_ant_z < 3 & cbcl_scr_syn_internal_r_z > -3 & cbcl_scr_syn_internal_r_z < 3 & pds_p_ss_category == "Pre")
# nrow(data_no_CBCL_lOFC_ant_outliers_females_prepubertal) #619
# data_no_CBCL_lOFC_ant_outliers_males_prepubertal <- subset(PDS_correct_males, lOFC_rvsn_ant_z > -3 & lOFC_rvsn_ant_z < 3 & cbcl_scr_syn_internal_r_z > -3 & cbcl_scr_syn_internal_r_z < 3 &  pds_p_ss_category == "Pre")
# nrow(data_no_CBCL_lOFC_ant_outliers_males_prepubertal) #1501
# 
# # No CBCL or or medial OFC (mOFC) anticipation outliers.
# data_no_CBCL_mOFC_ant_outliers <- subset(PDS_correct, mOFC_rvsn_ant_z > -3 & mOFC_rvsn_ant_z < 3 & cbcl_scr_syn_internal_r_z > -3 & cbcl_scr_syn_internal_r_z < 3)
# nrow(data_no_CBCL_mOFC_ant_outliers) # 4074.
# 
# data_no_CBCL_mOFC_ant_outliers_females <- subset(PDS_correct_females, mOFC_rvsn_ant_z > -3 & mOFC_rvsn_ant_z < 3 & cbcl_scr_syn_internal_r_z > -3 & cbcl_scr_syn_internal_r_z < 3)
# nrow(data_no_CBCL_mOFC_ant_outliers_females) # 1995.
# 
# data_no_CBCL_mOFC_ant_outliers_males <- subset(PDS_correct_males, mOFC_rvsn_ant_z > -3 & mOFC_rvsn_ant_z < 3 & cbcl_scr_syn_internal_r_z > -3 & cbcl_scr_syn_internal_r_z < 3)
# nrow(data_no_CBCL_mOFC_ant_outliers_males) # 2079.
# 
# data_no_CBCL_mOFC_ant_outliers_females_pubertal <- subset(PDS_correct_females, mOFC_rvsn_ant_z > -3 & mOFC_rvsn_ant_z < 3 & cbcl_scr_syn_internal_r_z > -3 & cbcl_scr_syn_internal_r_z < 3 & pds_p_ss_category != "Pre")
# nrow(data_no_CBCL_mOFC_ant_outliers_females_pubertal) # 1378.
# data_no_CBCL_mOFC_ant_outliers_males_pubertal <- subset(PDS_correct_males, mOFC_rvsn_ant_z > -3 & mOFC_rvsn_ant_z < 3 & cbcl_scr_syn_internal_r_z > -3 & cbcl_scr_syn_internal_r_z < 3 &  pds_p_ss_category != "Pre")
# nrow(data_no_CBCL_mOFC_ant_outliers_males_pubertal) # 575.
# 
# data_no_CBCL_mOFC_ant_outliers_females_prepubertal <- subset(PDS_correct_females, mOFC_rvsn_ant_z > -3 & mOFC_rvsn_ant_z < 3 & cbcl_scr_syn_internal_r_z > -3 & cbcl_scr_syn_internal_r_z < 3 & pds_p_ss_category == "Pre")
# nrow(data_no_CBCL_mOFC_ant_outliers_females_prepubertal) # 617.
# data_no_CBCL_mOFC_ant_outliers_males_prepubertal <- subset(PDS_correct_males, mOFC_rvsn_ant_z > -3 & mOFC_rvsn_ant_z < 3 & cbcl_scr_syn_internal_r_z > -3 & cbcl_scr_syn_internal_r_z < 3 &  pds_p_ss_category == "Pre")
# nrow(data_no_CBCL_mOFC_ant_outliers_males_prepubertal) # 1504.

# No CBCL or lateral OFC (lOFC) FEEDBACK outliers.
# data_no_CBCL_lOFC_feed_outliers <- subset(PDS_correct, lOFC_posvsneg_feedback_z > -3 & lOFC_posvsneg_feedback_z < 3 & cbcl_scr_syn_internal_r_z > -3 & cbcl_scr_syn_internal_r_z < 3)
# nrow(data_no_CBCL_lOFC_feed_outliers) #4086
# 
# data_no_CBCL_lOFC_feed_outliers_females <- subset(PDS_correct_females, lOFC_posvsneg_feedback_z > -3 & lOFC_posvsneg_feedback_z < 3 & cbcl_scr_syn_internal_r_z > -3 & cbcl_scr_syn_internal_r_z < 3)
# nrow(data_no_CBCL_lOFC_feed_outliers_females) # 1999
# 
# data_no_CBCL_lOFC_feed_outliers_males <- subset(PDS_correct_males, lOFC_posvsneg_feedback_z > -3 & lOFC_posvsneg_feedback_z < 3 & cbcl_scr_syn_internal_r_z > -3 & cbcl_scr_syn_internal_r_z < 3)
# nrow(data_no_CBCL_lOFC_feed_outliers_males) # 2087.
# 
# data_no_CBCL_lOFC_feed_outliers_females_pubertal <- subset(PDS_correct_females, lOFC_posvsneg_feedback_z > -3 & lOFC_posvsneg_feedback_z < 3 & cbcl_scr_syn_internal_r_z > -3 & cbcl_scr_syn_internal_r_z < 3 & pds_p_ss_category != "Pre")
# nrow(data_no_CBCL_lOFC_feed_outliers_females_pubertal) #1379
# data_no_CBCL_lOFC_feed_outliers_males_pubertal <- subset(PDS_correct_males, lOFC_posvsneg_feedback_z > -3 & lOFC_posvsneg_feedback_z < 3 & cbcl_scr_syn_internal_r_z > -3 & cbcl_scr_syn_internal_r_z < 3 &  pds_p_ss_category != "Pre")
# nrow(data_no_CBCL_lOFC_feed_outliers_males_pubertal) #579
# 
# data_no_CBCL_lOFC_feed_outliers_females_prepubertal <- subset(PDS_correct_females, lOFC_posvsneg_feedback_z > -3 & lOFC_posvsneg_feedback_z < 3 & cbcl_scr_syn_internal_r_z > -3 & cbcl_scr_syn_internal_r_z < 3 & pds_p_ss_category == "Pre")
# nrow(data_no_CBCL_lOFC_feed_outliers_females_prepubertal) #620
# data_no_CBCL_lOFC_feed_outliers_males_prepubertal <- subset(PDS_correct_males, lOFC_posvsneg_feedback_z > -3 & lOFC_posvsneg_feedback_z < 3 & cbcl_scr_syn_internal_r_z > -3 & cbcl_scr_syn_internal_r_z < 3 &  pds_p_ss_category == "Pre")
# nrow(data_no_CBCL_lOFC_feed_outliers_males_prepubertal) #1508
# 
# # No CBCL or medial OFC (mOFC) FEEDBACK outliers.
# data_no_CBCL_mOFC_feed_outliers <- subset(PDS_correct, mOFC_posvsneg_feedback_z > -3 & mOFC_posvsneg_feedback_z < 3 & cbcl_scr_syn_internal_r_z > -3 & cbcl_scr_syn_internal_r_z < 3)
# nrow(data_no_CBCL_mOFC_feed_outliers) # 4087.
# 
# data_no_CBCL_mOFC_feed_outliers_females <- subset(PDS_correct_females, mOFC_posvsneg_feedback_z > -3 & mOFC_posvsneg_feedback_z < 3 & cbcl_scr_syn_internal_r_z > -3 & cbcl_scr_syn_internal_r_z < 3)
# nrow(data_no_CBCL_mOFC_feed_outliers_females) # 2001.
# 
# data_no_CBCL_mOFC_feed_outliers_males <- subset(PDS_correct_males, mOFC_posvsneg_feedback_z > -3 & mOFC_posvsneg_feedback_z < 3 & cbcl_scr_syn_internal_r_z > -3 & cbcl_scr_syn_internal_r_z < 3)
# nrow(data_no_CBCL_mOFC_feed_outliers_males) # 2086.
# 
# data_no_CBCL_mOFC_feed_outliers_females_pubertal <- subset(PDS_correct_females, mOFC_posvsneg_feedback_z > -3 & mOFC_posvsneg_feedback_z < 3 & cbcl_scr_syn_internal_r_z > -3 & cbcl_scr_syn_internal_r_z < 3 & pds_p_ss_category != "Pre")
# nrow(data_no_CBCL_mOFC_feed_outliers_females_pubertal) # 1381.
# data_no_CBCL_mOFC_feed_outliers_males_pubertal <- subset(PDS_correct_males, mOFC_posvsneg_feedback_z > -3 & mOFC_posvsneg_feedback_z < 3 & cbcl_scr_syn_internal_r_z > -3 & cbcl_scr_syn_internal_r_z < 3 &  pds_p_ss_category != "Pre")
# nrow(data_no_CBCL_mOFC_feed_outliers_males_pubertal) # 579.
# 
# data_no_CBCL_mOFC_feed_outliers_females_prepubertal <- subset(PDS_correct_females, mOFC_posvsneg_feedback_z > -3 & mOFC_posvsneg_feedback_z < 3 & cbcl_scr_syn_internal_r_z > -3 & cbcl_scr_syn_internal_r_z < 3 & pds_p_ss_category == "Pre")
# nrow(data_no_CBCL_mOFC_feed_outliers_females_prepubertal) # 620.
# data_no_CBCL_mOFC_feed_outliers_males_prepubertal <- subset(PDS_correct_males, mOFC_posvsneg_feedback_z > -3 & mOFC_posvsneg_feedback_z < 3 & cbcl_scr_syn_internal_r_z > -3 & cbcl_scr_syn_internal_r_z < 3 &  pds_p_ss_category == "Pre")
# nrow(data_no_CBCL_mOFC_feed_outliers_males_prepubertal) # 1507.
# 
# # No CBCL or testosterone outliers.
# data_no_CBCL_test_outliers <- subset(PDS_correct, hormone_scr_ert_mean_z > -3 & hormone_scr_ert_mean_z < 3 & cbcl_scr_syn_internal_r_z > -3 & cbcl_scr_syn_internal_r_z < 3)
# data_no_CBCL_test_outliers_females <- subset(PDS_correct_females, hormone_scr_ert_mean_z > -3 & hormone_scr_ert_mean_z < 3 & cbcl_scr_syn_internal_r_z > -3 & cbcl_scr_syn_internal_r_z < 3)
# data_no_CBCL_test_outliers_males <- subset(PDS_correct_males, hormone_scr_ert_mean_z > -3 & hormone_scr_ert_mean_z < 3 & cbcl_scr_syn_internal_r_z > -3 & cbcl_scr_syn_internal_r_z < 3)
# 
# 
# # No CBCL or BIS/BAS outliers.
# data_no_CBCL_bisbas_outliers <- subset(data_no_bisbas_outliers, cbcl_scr_syn_internal_r_z > -3 & cbcl_scr_syn_internal_r_z < 3)
# data_no_CBCL_bisbas_outliers_females <- subset(data_no_bisbas_outliers_females, cbcl_scr_syn_internal_r_z > -3 & cbcl_scr_syn_internal_r_z < 3)
# data_no_CBCL_bisbas_outliers_males <- subset(data_no_bisbas_outliers_males, cbcl_scr_syn_internal_r_z > -3 & cbcl_scr_syn_internal_r_z < 3)
#
# No MID Reaction Time or CBCL outliers.
#data_no_RT_MID_CBCL_outliers_females<- subset(data_no_RT_MID_outliers_females, cbcl_scr_syn_internal_r_z > -3 & cbcl_scr_syn_internal_r_z < 3)
#data_no_RT_MID_CBCL_outliers_males<- subset(data_no_RT_MID_outliers_males, cbcl_scr_syn_internal_r_z > -3 & cbcl_scr_syn_internal_r_z < 3)

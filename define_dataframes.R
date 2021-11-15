# Call this function after you have loaded "nda30_exploratory.csv" into data frame named "fulldata".
# Instead of writing this long code for every single script, we are going to call one script to do it.
# This way, we can make sure we are all loading in the exact same data and working with the exact same dataframes because we are using identical code (from this one script).
# If we need to edit anything about our dataframes, we can do so in this script.

nrow(fulldata)
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
                    "hormone_scr_hse_rep2_nd")]


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

# Exclude two participants who have multiple rows for baseline.
data <- subset(data, src_subject_id != "NDAR_INV2ZA2LC3N" & src_subject_id != "NDAR_INVJ9GNXGK5")

# Use only data from baseline.
data <- subset(data,eventname == "baseline_year_1_arm_1")

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


# The filter scheme is to check records for any RA saliva collection notes. If true, then flag the record. 
# Then check flagged records and see if the Salimetrics value is out of range per hormone.
# If yes, then change value to NA, else keep the existing values for each replicate.
# Finally, average the two replicates into a new field.
data$hormone_notes_ss <- as.numeric(data$hormon_sal_notes_y___2) + 
  as.numeric(data$hormon_sal_notes_y___3) +
  as.numeric(data$hormon_sal_notes_y___4) + 
  as.numeric(data$hormon_sal_notes_y___5) + 
  as.numeric(data$hormon_sal_notes_y___6)
rownums <- which(data$hormone_notes_ss > 1)

# Filter out wonky tesosterone values.
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

# Scale testosterone data.
data$hormone_scr_ert_mean_z <- scale(data$filtered_testosterone)

# Use data with only correct PDS scores.
# This also removes any rows with NA values in PDS_score.
PDS_correct <- subset(data, PDS_score < 5) #Be mindful that PDS category goes from 1 to 5, while PDS_score goes from 1 to 4 (continuous).

# There are two people with a PDS category score of 5 ("post"), which will bias the category estimates, so we are removing them.
# post_pubertal <- subset(PDS_correct, pds_p_ss_category == "Post")
PDS_correct <- subset(PDS_correct, pds_p_ss_category != "Post")
mean_PDS_score <- mean(PDS_correct$PDS_score)
sd_PDS_score <- sd(PDS_correct$PDS_score)
PDS_correct$PDS_score_z <- (PDS_correct$PDS_score-mean_PDS_score)/sd_PDS_score 

# Exclude based on ABCD's recommendation for MID imaging, including only those with both usable task and imaging data here.
# Start with neuroimaging flag (exclude people ABCD says to exclude based on MID imaging data).

MID_imaging_correct <- subset(PDS_correct, imgincl_mid_include ==1) 

# Next, use behavioral task flag to also exclude people ABCD says to exclude based on MID task data.
MID_imaging_correct <- subset(MID_imaging_correct, tfmri_mid_beh_performflag ==1)

# Keep a version that is just the task (not based on neuroimaging) for our behavioral analyses.
MID_task_correct <- subset(PDS_correct, tfmri_mid_beh_performflag ==1)

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

MID_task_correct_females <- subset(MID_task_correct, sex == "F")
MID_task_correct_males <- subset(MID_task_correct, sex == "M")

MID_imaging_correct_females <- subset(MID_imaging_correct, sex == "F")
MID_imaging_correct_males <- subset(MID_imaging_correct, sex == "M")

# Create different subsets of the data based on removing outliers for specific variables of interest.
# For anything that is not related to the MID task, use PDS_correct.
# For anything that is related to the behavioral data from the MID task (and not the imaging data), use MID_task_correct.
# For anything that is related to the imaging data from the MID task, use MID_imaging_correct.

#### Lateral OFC (lOFC) and medial OFC (mOFC) reward anticipation and reward feedback. #### 

# No lateral OFC (lOFC) anticipation outliers.
data_no_lOFC_ant_outliers <- subset(MID_imaging_correct, lOFC_rvsn_ant_z > -3 & lOFC_rvsn_ant_z < 3)

data_no_lOFC_ant_outliers_females <- subset(MID_imaging_correct_females, lOFC_rvsn_ant_z > -3 & lOFC_rvsn_ant_z < 3)

data_no_lOFC_ant_outliers_males <- subset(MID_imaging_correct_males, lOFC_rvsn_ant_z > -3 & lOFC_rvsn_ant_z < 3)

data_no_lOFC_ant_outliers_females_pubertal <- subset(MID_imaging_correct_females, lOFC_rvsn_ant_z > -3 & lOFC_rvsn_ant_z < 3 & pds_p_ss_category != "Pre")
data_no_lOFC_ant_outliers_males_pubertal <- subset(MID_imaging_correct_males, lOFC_rvsn_ant_z > -3 & lOFC_rvsn_ant_z < 3 &  pds_p_ss_category != "Pre")

data_no_lOFC_ant_outliers_females_prepubertal <- subset(MID_imaging_correct_females, lOFC_rvsn_ant_z > -3 & lOFC_rvsn_ant_z < 3 & pds_p_ss_category == "Pre")
data_no_lOFC_ant_outliers_males_prepubertal <- subset(MID_imaging_correct_males, lOFC_rvsn_ant_z > -3 & lOFC_rvsn_ant_z < 3 &  pds_p_ss_category == "Pre")

# No medial OFC (mOFC) anticipation outliers.
data_no_mOFC_ant_outliers <- subset(MID_imaging_correct, mOFC_rvsn_ant_z > -3 & mOFC_rvsn_ant_z < 3)

data_no_mOFC_ant_outliers_females <- subset(MID_imaging_correct_females, mOFC_rvsn_ant_z > -3 & mOFC_rvsn_ant_z < 3)

data_no_mOFC_ant_outliers_males <- subset(MID_imaging_correct_males, mOFC_rvsn_ant_z > -3 & mOFC_rvsn_ant_z < 3)

data_no_mOFC_ant_outliers_females_pubertal <- subset(MID_imaging_correct_females, mOFC_rvsn_ant_z > -3 & mOFC_rvsn_ant_z < 3 & pds_p_ss_category != "Pre")
data_no_mOFC_ant_outliers_males_pubertal <- subset(MID_imaging_correct_males, mOFC_rvsn_ant_z > -3 & mOFC_rvsn_ant_z < 3 &  pds_p_ss_category != "Pre")

data_no_mOFC_ant_outliers_females_prepubertal <- subset(MID_imaging_correct_females, mOFC_rvsn_ant_z > -3 & mOFC_rvsn_ant_z < 3 & pds_p_ss_category == "Pre")
data_no_mOFC_ant_outliers_males_prepubertal <- subset(MID_imaging_correct_males, mOFC_rvsn_ant_z > -3 & mOFC_rvsn_ant_z < 3 &  pds_p_ss_category == "Pre")

# No lateral OFC (lOFC) feedback outliers.
data_no_lOFC_feed_outliers <- subset(MID_imaging_correct, lOFC_posvsneg_feedback_z > -3 & lOFC_posvsneg_feedback_z < 3)

data_no_lOFC_feed_outliers_females <- subset(MID_imaging_correct_females, lOFC_posvsneg_feedback_z > -3 & lOFC_posvsneg_feedback_z < 3)

data_no_lOFC_feed_outliers_males <- subset(MID_imaging_correct_males, lOFC_posvsneg_feedback_z > -3 & lOFC_posvsneg_feedback_z < 3)

data_no_lOFC_feed_outliers_females_pubertal <- subset(MID_imaging_correct_females, lOFC_posvsneg_feedback_z > -3 & lOFC_posvsneg_feedback_z < 3 & pds_p_ss_category != "Pre")

data_no_lOFC_feed_outliers_males_pubertal <- subset(MID_imaging_correct_males, lOFC_posvsneg_feedback_z > -3 & lOFC_posvsneg_feedback_z < 3 &  pds_p_ss_category != "Pre")

data_no_lOFC_feed_outliers_females_prepubertal <- subset(MID_imaging_correct_females, lOFC_posvsneg_feedback_z > -3 & lOFC_posvsneg_feedback_z < 3 & pds_p_ss_category == "Pre")

data_no_lOFC_feed_outliers_males_prepubertal <- subset(MID_imaging_correct_males, lOFC_posvsneg_feedback_z > -3 & lOFC_posvsneg_feedback_z < 3 &  pds_p_ss_category == "Pre")

# No medial OFC (mOFC) feedback outliers.
data_no_mOFC_feed_outliers <- subset(MID_imaging_correct, mOFC_posvsneg_feedback_z > -3 & mOFC_posvsneg_feedback_z < 3)

data_no_mOFC_feed_outliers_females <- subset(MID_imaging_correct_females, mOFC_posvsneg_feedback_z > -3 & mOFC_posvsneg_feedback_z < 3)

data_no_mOFC_feed_outliers_males <- subset(MID_imaging_correct_males, mOFC_posvsneg_feedback_z > -3 & mOFC_posvsneg_feedback_z < 3)

data_no_mOFC_feed_outliers_females_pubertal <- subset(MID_imaging_correct_females, mOFC_posvsneg_feedback_z > -3 & mOFC_posvsneg_feedback_z < 3 & pds_p_ss_category != "Pre")

data_no_mOFC_feed_outliers_males_pubertal <- subset(MID_imaging_correct_males, mOFC_posvsneg_feedback_z > -3 & mOFC_posvsneg_feedback_z < 3 &  pds_p_ss_category != "Pre")

data_no_mOFC_feed_outliers_females_prepubertal <- subset(MID_imaging_correct_females, mOFC_posvsneg_feedback_z > -3 & mOFC_posvsneg_feedback_z < 3 & pds_p_ss_category == "Pre")

data_no_mOFC_feed_outliers_males_prepubertal <- subset(MID_imaging_correct_males, mOFC_posvsneg_feedback_z > -3 & mOFC_posvsneg_feedback_z < 3 &  pds_p_ss_category == "Pre")

# No testosterone outliers.
data_no_test_outliers <- subset(PDS_correct, hormone_scr_ert_mean_z > -3 & hormone_scr_ert_mean_z < 3)
data_no_test_outliers_females <- subset(PDS_correct_females, hormone_scr_ert_mean_z > -3 & hormone_scr_ert_mean_z < 3)
data_no_test_outliers_males <- subset(PDS_correct_males, hormone_scr_ert_mean_z > -3 & hormone_scr_ert_mean_z < 3)

# Get z scores for bis bas rr scores.
mean_bisbas <- mean(PDS_correct$bisbas_ss_basm_rr, na.rm=TRUE)
sd_bisbas <- sd(PDS_correct$bisbas_ss_basm_rr, na.rm=TRUE)
PDS_correct$bisbas_ss_basm_rr_z <- (PDS_correct$bisbas_ss_basm_rr-mean_bisbas)/sd_bisbas

data_no_bisbas_outliers <- subset(PDS_correct, bisbas_ss_basm_rr_z > -3 & bisbas_ss_basm_rr_z < 3)
data_no_bisbas_outliers_females <- subset(data_no_bisbas_outliers, sex == "F")
data_no_bisbas_outliers_males <- subset(data_no_bisbas_outliers, sex == "M")

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

#### Nucleus accumbens, caudate, and putamen (reward anticipation and reward feedback). #### 
# Anticipation stage.
# No accumbens outliers.
data_no_accumbens_ant_outliers_females <- subset(MID_imaging_correct_females, accumbens_rvsn_ant_z > -3 & accumbens_rvsn_ant_z < 3)
data_no_accumbens_ant_outliers_males <- subset(MID_imaging_correct_males, accumbens_rvsn_ant_z > -3 & accumbens_rvsn_ant_z < 3)

# No caudate outliers.
data_no_caudate_ant_outliers_females <- subset(MID_imaging_correct_females, caudate_rvsn_ant_z > -3 & caudate_rvsn_ant_z < 3)
data_no_caudate_ant_outliers_males <- subset(MID_imaging_correct_males, caudate_rvsn_ant_z > -3 & caudate_rvsn_ant_z < 3)

# No putamen outliers.
data_no_putamen_ant_outliers_females <- subset(MID_imaging_correct_females, putamen_rvsn_ant_z > -3 & putamen_rvsn_ant_z < 3)
data_no_putamen_ant_outliers_males <- subset(MID_imaging_correct_males, putamen_rvsn_ant_z > -3 & putamen_rvsn_ant_z < 3)

# Feedback stage.
# No accumbens outliers.
data_no_accumbens_feed_outliers <- subset(MID_imaging_correct, accumbens_posvsneg_feedback_z > -3 & accumbens_posvsneg_feedback_z < 3) 
data_no_accumbens_feed_outliers_females <- subset(MID_imaging_correct_females, accumbens_posvsneg_feedback_z > -3 & accumbens_posvsneg_feedback_z < 3)
data_no_accumbens_feed_outliers_males <- subset(MID_imaging_correct_males, accumbens_posvsneg_feedback_z > -3 & accumbens_posvsneg_feedback_z < 3)

# No caudate outliers.
data_no_caudate_feed_outliers <- subset(MID_imaging_correct, caudate_posvsneg_feedback_z > -3 & caudate_posvsneg_feedback_z < 3) 
data_no_caudate_feed_outliers_females <- subset(MID_imaging_correct_females, caudate_posvsneg_feedback_z > -3 & caudate_posvsneg_feedback_z < 3)
data_no_caudate_feed_outliers_males <- subset(MID_imaging_correct_males, caudate_posvsneg_feedback_z > -3 & caudate_posvsneg_feedback_z < 3)

# No putamen outliers.
data_no_putamen_feed_outliers <- subset(MID_imaging_correct, putamen_posvsneg_feedback_z > -3 & putamen_posvsneg_feedback_z < 3) 
data_no_putamen_feed_outliers_females <- subset(MID_imaging_correct_females, putamen_posvsneg_feedback_z > -3 & putamen_posvsneg_feedback_z < 3)
data_no_putamen_feed_outliers_males <- subset(MID_imaging_correct_males, putamen_posvsneg_feedback_z > -3 & putamen_posvsneg_feedback_z < 3)

## No reward and no testosterone outliers. ##
# Anticipation stage.

# No accumbens outliers.
data_no_accumbens_ant_no_test_outliers_females <- subset(MID_imaging_correct_females, accumbens_rvsn_ant_z > -3 & accumbens_rvsn_ant_z < 3 & hormone_scr_ert_mean_z > -3 & hormone_scr_ert_mean_z < 3 )
data_no_accumbens_ant_no_test_outliers_males <- subset(MID_imaging_correct_males, accumbens_rvsn_ant_z > -3 & accumbens_rvsn_ant_z < 3 & hormone_scr_ert_mean_z > -3 & hormone_scr_ert_mean_z < 3 )

# No caudate outliers.
data_no_caudate_ant_no_test_outliers_females <- subset(MID_imaging_correct_females, caudate_rvsn_ant_z > -3 & caudate_rvsn_ant_z < 3 & hormone_scr_ert_mean_z > -3 & hormone_scr_ert_mean_z < 3 )
data_no_caudate_ant_no_test_outliers_males <- subset(MID_imaging_correct_males, caudate_rvsn_ant_z > -3 & caudate_rvsn_ant_z < 3 & hormone_scr_ert_mean_z > -3 & hormone_scr_ert_mean_z < 3)

# No putamen outliers.
data_no_putamen_ant_no_test_outliers_females <- subset(MID_imaging_correct_females, putamen_rvsn_ant_z > -3 & putamen_rvsn_ant_z < 3 & hormone_scr_ert_mean_z > -3 & hormone_scr_ert_mean_z < 3)
data_no_putamen_ant_no_test_outliers_males <- subset(MID_imaging_correct_males, putamen_rvsn_ant_z > -3 & putamen_rvsn_ant_z < 3 & hormone_scr_ert_mean_z > -3 & hormone_scr_ert_mean_z < 3)

## No reward and no testosterone outliers. ##
# Feedback stage.
# No accumbens outliers.
data_no_accumbens_feed_no_test_outliers <- subset(MID_imaging_correct, accumbens_posvsneg_feedback_z > -3 & accumbens_posvsneg_feedback_z < 3 & hormone_scr_ert_mean_z > -3 & hormone_scr_ert_mean_z < 3) 
data_no_accumbens_feed_no_test_outliers_females <- subset(MID_imaging_correct_females, accumbens_posvsneg_feedback_z > -3 & accumbens_posvsneg_feedback_z < 3 & hormone_scr_ert_mean_z > -3 & hormone_scr_ert_mean_z < 3)
data_no_accumbens_feed_no_test_outliers_males <- subset(MID_imaging_correct_males, accumbens_posvsneg_feedback_z > -3 & accumbens_posvsneg_feedback_z < 3 & hormone_scr_ert_mean_z > -3 & hormone_scr_ert_mean_z < 3)

# No caudate outliers.
data_no_caudate_feed_no_test_outliers <- subset(MID_imaging_correct, caudate_posvsneg_feedback_z > -3 & caudate_posvsneg_feedback_z < 3 & hormone_scr_ert_mean_z > -3 & hormone_scr_ert_mean_z < 3) 
data_no_caudate_feed_no_test_outliers_females <- subset(MID_imaging_correct_females, caudate_posvsneg_feedback_z > -3 & caudate_posvsneg_feedback_z < 3 & hormone_scr_ert_mean_z > -3 & hormone_scr_ert_mean_z < 3)
data_no_caudate_feed_no_test_outliers_males <- subset(MID_imaging_correct_males, caudate_posvsneg_feedback_z > -3 & caudate_posvsneg_feedback_z < 3 & hormone_scr_ert_mean_z > -3 & hormone_scr_ert_mean_z < 3)

# No putamen outliers.
data_no_putamen_feed_no_test_outliers <- subset(MID_imaging_correct, putamen_posvsneg_feedback_z > -3 & putamen_posvsneg_feedback_z < 3 & hormone_scr_ert_mean_z > -3 & hormone_scr_ert_mean_z < 3) 
data_no_putamen_feed_no_test_outliers_females <- subset(MID_imaging_correct_females, putamen_posvsneg_feedback_z > -3 & putamen_posvsneg_feedback_z < 3 & hormone_scr_ert_mean_z > -3 & hormone_scr_ert_mean_z < 3)
data_no_putamen_feed_outliers_no_test_males <- subset(MID_imaging_correct_males, putamen_posvsneg_feedback_z > -3 & putamen_posvsneg_feedback_z < 3 & hormone_scr_ert_mean_z > -3 & hormone_scr_ert_mean_z < 3)

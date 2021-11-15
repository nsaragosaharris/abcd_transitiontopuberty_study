# This script calculates the averages to use for the MRI data.
# It averages the right and left hemisphere values and also creates a composite striatum value by averaging the accumbens, caudate, and putamen.

library(ggplot2)
library(gamm4)
library(dplyr)
library(sjPlot)

data_dir = ((dirname(here()))) 

data_folder <- file.path(data_dir,"ABCD","derivatives")

file_name <- "nda30.csv" # specify file name here. 

nda30 <- read.csv(file.path(data_folder,file_name))
nrow(nda30) # 54599.

MRI_columns <- c("tfmri_ma_acdn_b_scs_aarh", # Accumbens reward vs. neutral anticipation.
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
"tfmri_ma_rpvnfb_b_cds_lobofrlh")

nda30[MRI_columns] <- lapply(nda30[MRI_columns], as.numeric)  # Make sure that they are numeric (they are read in as characters).


# Average right and left hemispheres.
# Note: If either is "NA", then the whole thing will be "NA".
nda30$accumbens_rvsn_ant <- (nda30$tfmri_ma_acdn_b_scs_aarh + nda30$tfmri_ma_acdn_b_scs_aalh)/2
nda30$caudate_rvsn_ant <- (nda30$tfmri_ma_acdn_b_scs_cdrh + nda30$tfmri_ma_acdn_b_scs_cdlh)/2
nda30$putamen_rvsn_ant <- (nda30$tfmri_ma_acdn_b_scs_ptrh + nda30$tfmri_ma_acdn_b_scs_ptlh)/2
nda30$mOFC_rvsn_ant <- (nda30$tfmri_ma_arvn_b_cds_mobofrrh + nda30$tfmri_ma_arvn_b_cds_mobofrlh)/2
nda30$lOFC_rvsn_ant <- (nda30$tfmri_ma_arvn_b_cds_lobofrrh + nda30$tfmri_ma_arvn_b_cds_lobofrlh)/2

# Do the same for feedback stage as well.
nda30$accumbens_posvsneg_feedback <- (nda30$tfmri_ma_rpvnfb_b_scs_aarh + nda30$tfmri_ma_rpvnfb_b_scs_aalh)/2
nda30$caudate_posvsneg_feedback <- (nda30$tfmri_ma_rpvnfb_b_scs_cdrh + nda30$tfmri_ma_rpvnfb_b_scs_cdlh)/2
nda30$putamen_posvsneg_feedback <- (nda30$tfmri_ma_rpvnfb_b_scs_ptrh + nda30$tfmri_ma_rpvnfb_b_scs_ptlh)/2
nda30$mOFC_posvsneg_feedback <- (nda30$tfmri_ma_rpvnfb_b_cds_mobofrrh + nda30$tfmri_ma_rpvnfb_b_cds_mobofrlh)/2
nda30$lOFC_posvsneg_feedback <- (nda30$tfmri_ma_rpvnfb_b_cds_lobofrrh + nda30$tfmri_ma_rpvnfb_b_cds_lobofrlh)/2

# striatum_rvsn_ant = reward vs. neutral anticipation.
nda30$striatum_rvsn_ant <- (nda30$accumbens_rvsn_ant + 
                             nda30$caudate_rvsn_ant+
                             nda30$putamen_rvsn_ant)/3

# striatum_posvsneg_feedback = reward positive vs. negative feedback.
nda30$striatum_posvsneg_feedback <- (nda30$accumbens_posvsneg_feedback +
                                      nda30$caudate_posvsneg_feedback +
                                      nda30$putamen_posvsneg_feedback)/3

# Calculate z scores for all of these values.
nda30$accumbens_rvsn_ant_z <- scale(nda30$accumbens_rvsn_ant)
nda30$caudate_rvsn_ant_z <- scale(nda30$caudate_rvsn_ant)
nda30$putamen_rvsn_ant_z <- scale(nda30$putamen_rvsn_ant)
nda30$mOFC_rvsn_ant_z <- scale(nda30$mOFC_rvsn_ant)
nda30$lOFC_rvsn_ant_z <- scale(nda30$lOFC_rvsn_ant)

nda30$accumbens_posvsneg_feedback_z <- scale(nda30$accumbens_posvsneg_feedback)
nda30$caudate_posvsneg_feedback_z <- scale(nda30$caudate_posvsneg_feedback)
nda30$putamen_posvsneg_feedback_z <- scale(nda30$putamen_posvsneg_feedback)
nda30$mOFC_posvsneg_feedback_z <- scale(nda30$mOFC_posvsneg_feedback)
nda30$lOFC_posvsneg_feedback_z <- scale(nda30$lOFC_posvsneg_feedback)

nda30$striatum_rvsn_ant_z <- scale(nda30$striatum_rvsn_ant)
nda30$striatum_posvsneg_feedback_z <- scale(nda30$striatum_posvsneg_feedback)

setwd(data_folder)
saveRDS(nda30, 'nda30.rds')
write.csv(nda30,'nda30.csv', row.names = FALSE)

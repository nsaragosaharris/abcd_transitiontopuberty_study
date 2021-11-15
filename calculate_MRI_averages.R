# This script calculates the averages to use for the MRI data.
# It averages the right and left hemisphere values and also creates a composite striatum value by averaging the accumbens, caudate, and putamen.

library(ggplot2)
library(gamm4)
library(dplyr)
library(sjPlot)

data_dir = ((dirname(here()))) 

data_folder <- file.path(data_dir,"ABCD","derivatives")

file_name <- "nda20.csv" # specify file name here. 

nda20 <- read.csv(file.path(data_folder,file_name))
nrow(nda20) # 54599.

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

nda20[MRI_columns] <- lapply(nda20[MRI_columns], as.numeric)  # Make sure that they are numeric (they are read in as characters).


# Average right and left hemispheres.
# Note: If either is "NA", then the whole thing will be "NA".
nda20$accumbens_rvsn_ant <- (nda20$tfmri_ma_acdn_b_scs_aarh + nda20$tfmri_ma_acdn_b_scs_aalh)/2
nda20$caudate_rvsn_ant <- (nda20$tfmri_ma_acdn_b_scs_cdrh + nda20$tfmri_ma_acdn_b_scs_cdlh)/2
nda20$putamen_rvsn_ant <- (nda20$tfmri_ma_acdn_b_scs_ptrh + nda20$tfmri_ma_acdn_b_scs_ptlh)/2
nda20$mOFC_rvsn_ant <- (nda20$tfmri_ma_arvn_b_cds_mobofrrh + nda20$tfmri_ma_arvn_b_cds_mobofrlh)/2
nda20$lOFC_rvsn_ant <- (nda20$tfmri_ma_arvn_b_cds_lobofrrh + nda20$tfmri_ma_arvn_b_cds_lobofrlh)/2

# Do the same for feedback stage as well.
nda20$accumbens_posvsneg_feedback <- (nda20$tfmri_ma_rpvnfb_b_scs_aarh + nda20$tfmri_ma_rpvnfb_b_scs_aalh)/2
nda20$caudate_posvsneg_feedback <- (nda20$tfmri_ma_rpvnfb_b_scs_cdrh + nda20$tfmri_ma_rpvnfb_b_scs_cdlh)/2
nda20$putamen_posvsneg_feedback <- (nda20$tfmri_ma_rpvnfb_b_scs_ptrh + nda20$tfmri_ma_rpvnfb_b_scs_ptlh)/2
nda20$mOFC_posvsneg_feedback <- (nda20$tfmri_ma_rpvnfb_b_cds_mobofrrh + nda20$tfmri_ma_rpvnfb_b_cds_mobofrlh)/2
nda20$lOFC_posvsneg_feedback <- (nda20$tfmri_ma_rpvnfb_b_cds_lobofrrh + nda20$tfmri_ma_rpvnfb_b_cds_lobofrlh)/2

# striatum_rvsn_ant = reward vs. neutral anticipation.
nda20$striatum_rvsn_ant <- (nda20$accumbens_rvsn_ant + 
                             nda20$caudate_rvsn_ant+
                             nda20$putamen_rvsn_ant)/3

# striatum_posvsneg_feedback = reward positive vs. negative feedback.
nda20$striatum_posvsneg_feedback <- (nda20$accumbens_posvsneg_feedback +
                                      nda20$caudate_posvsneg_feedback +
                                      nda20$putamen_posvsneg_feedback)/3

# Calculate z scores for all of these values.
nda20$accumbens_rvsn_ant_z <- scale(nda20$accumbens_rvsn_ant)
nda20$caudate_rvsn_ant_z <- scale(nda20$caudate_rvsn_ant)
nda20$putamen_rvsn_ant_z <- scale(nda20$putamen_rvsn_ant)
nda20$mOFC_rvsn_ant_z <- scale(nda20$mOFC_rvsn_ant)
nda20$lOFC_rvsn_ant_z <- scale(nda20$lOFC_rvsn_ant)

nda20$accumbens_posvsneg_feedback_z <- scale(nda20$accumbens_posvsneg_feedback)
nda20$caudate_posvsneg_feedback_z <- scale(nda20$caudate_posvsneg_feedback)
nda20$putamen_posvsneg_feedback_z <- scale(nda20$putamen_posvsneg_feedback)
nda20$mOFC_posvsneg_feedback_z <- scale(nda20$mOFC_posvsneg_feedback)
nda20$lOFC_posvsneg_feedback_z <- scale(nda20$lOFC_posvsneg_feedback)

nda20$striatum_rvsn_ant_z <- scale(nda20$striatum_rvsn_ant)
nda20$striatum_posvsneg_feedback_z <- scale(nda20$striatum_posvsneg_feedback)

setwd(data_folder)
saveRDS(nda20, 'nda20.rds')
write.csv(nda20,'nda20.csv', row.names = FALSE)

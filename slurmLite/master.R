
# write master and runsim scripts

library(EpiModelHPC)

vars <- list(TP = c(0.1, 0.2),
             TP2 = c(0.2, 0.4))
sbatch_master(vars,
              narray = 2,
              simno.start = 1000,
              master.file = "master.sh",
              build.runsim = TRUE)

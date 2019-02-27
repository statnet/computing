
# Install EpiModel Stack
install.packages("EpiModel", dependencies = TRUE)

# Install Extra Helper Packages
install.packages("tidyverse", dep = TRUE)
install.packages("devtools", dep = TRUE)
install.packages("remotes", dep = TRUE)

# Latest Dev Versions of Packages
remotes::install_github(c("statnet/network",
                          "statnet/statnet.common",
                          "statnet/ergm",
                          "statnet/tergm"))

remotes::install_github(c("statnet/EpiModel",
                          "statnet/EpiModelHPC",
                          "statnet/tergmLite",
                          "EpiModel/EpiABC"))

remotes::install_github("EpiModel/EpiModelHIV-p")
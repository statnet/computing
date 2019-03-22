
# Install EpiModel Stack
install.packages("EpiModel")

# Install remotes to install Github packages
install.packages("remotes")

remotes::install_github(c("statnet/network",
                          "statnet/statnet.common",
                          "statnet/ergm",
                          "statnet/tergm"))

remotes::install_github(c("statnet/EpiModel",
                          "statnet/EpiModelHPC",
                          "statnet/tergmLite",
                          "EpiModel/EpiABC"))

remotes::install_github("EpiModel/EpiModelHIV-p", ref = "Your-Branch-Name")


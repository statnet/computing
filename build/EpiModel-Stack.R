
# Install EpiModel Stack
install.packages("EpiModel")

# Install remotes to install Github packages
install.packages("remotes")

remotes::install_github(c("statnet/network",
                          "statnet/networkDynamic",
                          "statnet/statnet.common"))
remotes::install_github("statnet/ergm", ref = "8b30e92")
remotes::install_github("statnet/tergm", ref = "d3af1355")

remotes::install_github(c("statnet/EpiModel",
                          "statnet/EpiModelHPC",
                          "statnet/tergmLite",
                          "EpiModel/EpiABC"))

remotes::install_github("EpiModel/EpiModelHIV-p", ref = "Your-Branch-Name")


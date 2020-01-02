# If private github packages are needed create a token by going to
# https://github.com/settings/tokens
# (Settings / Developer settings / Personal access token)
# Select the `repo` scope

# If your token is not stored as an environment variable
# This script accept a GitHub token as an optional argument
args <- commandArgs(TRUE)
if (! is.null(args[1]))
  Sys.setenv(GITHUB_PAT = args[1])

# Packages installation
if (file.exists("renv.lock")) {# Restore from a lockfile if it exists.

  renv::restore(confirm = FALSE) # Do not ask for confirmation

} else { # Otherwise install the packages and make a lockfile

  # CRAN packages
  install.packages(c(
    "remotes",
    "callr",
    "dplyr",
    "tidyr"
  ))

  # Github packages
  renv::install(c(
    "statnet/network",
    "statnet/EpiModel",
    "statnet/EpiModelHPC",
    "statnet/tergmLite",
    "EpiModel/EpiABC",
    "EpiModel/ARTnetData",
    "EpiModel/ARTnet@ARTnet_hivprev",
    "EpiModel/EpiModelHIV-p@db316a6")
  )

  # save lockfile | save all packages even if they are not used by the project
  renv::snapshot(type = "simple")
}

# Reproducible R environments

## Problems to be solved

1. How to keep track of every R package version required for a research project
2. How to deal with different projects using different versions of a package
3. How to ensure our project can be run on another machine at another time

## The renv package (by Rstudio)

Description from the [renv website](https://rstudio.github.io/renv/)

> ## Overview
>
>The renv package helps you create reproducible environments for your R projects. Use renv to make your R projects more:
>
>Isolated: Installing a new or updated package for one project won’t break your other projects, and vice versa. That’s because renv gives each project its own private package library.
>
>Portable: Easily transport your projects from one computer to another, even across different platforms. renv makes it easy to install the packages your project depends on.
>
>Reproducible: renv records the exact package versions you depend on, and ensures those exact versions are the ones that get installed wherever you go.
>Installation
>
>Install from CRAN
>
> ```
>  install.packages("renv")
> ```
>
> ## Workflow
>
>Use `renv::init()` to initialize renv with a new or existing project. This will set up your project with a private library, and also make sure to install all of the packages you’re using into that library. The packages used in your project will be recorded into a lockfile, called renv.lock.
>
>As you work in your project, you may need to install or upgrade different packages. As these packages are installed, renv will automatically write renv.lock for you. The renv.lock lockfile records the state of your project’s private library, and can be used to restore the state of that library as required.
>
>Later, if you need to port your project to a new machine, you can call `renv::restore()` to reinstall all of the packages as declared in the lockfile.

## Example of a renv setup

This is the setup from a HIV modeling project using EpiModel. Once the setup is finished, 89 packages are installed (including the dependencies) and some packages require specific versions.

Two scripts were made to simplify the process:

1. "init_renv.R": Install and initialize renv non interactively
2. "install_stack.R": Restore the environment if a "renv.lock" is present or install the packages

### init_renv.R

This script is ran from the root of the project. `Rscript init_renv.R`

```
install.packages("renv")       # ensures that renv is install on the system
renv::consent(provided = true) # allows to run the script non interactively
renv::init(bare = t)           # initialize an empty library
```

### install_stack.R

This script is ran from the root of the project, after "init_renv.R".
`Rscript install_stack.R`

or `Rscript install_stack.R my_github_token`

If a "renv.lock" file is found, renv will restore the project with the exact version of each package.

If no lockfile is present, the script will install the packages described in the second part of the if/else statement. This method may lead to differences if some packages have been updated. This is even more true for github packages.


```
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
```

## renv cache

To save diskspace and install time, renv actually install all packages into a cache folder and links the relevant packages to each project library.

By default renv will store it's information in these folders:

| Platform | Location                           |
|----------|------------------------------------|
| Linux    | ~/.local/share/renv                |
| macOS    | ~/Library/Application Support/renv |
| Windows  | %LOCALAPPDATA%/renv                |

This can be a problem on HPC such as hyak where the home folder is limited in size. You can change the default renv folder by adding this line to your ~/.bashrc.

```
export RENV_PATHS_ROOT="/gscratch/csde/<user>/<renv_root_folder>/"
```

The renv root folder can be shared among users.

## Things to keep in mind when using renv

### Working directory

renv is loaded automatically when you start R from the root of the project. However, if you start R from another folder (even child folder), R will not initialize renv as it requires the ".Rprofile" created by `renv::init()`.

In any case, you should always run R from the root of your project, use relative path and never use `setwd`. If needed use [the here package](https://rstudio.github.io/renv/)

### Dependencies

By default `renv::snapshot()` will only record the packages needed for the project (i.e. loaded by `library` or `package::funciton`). To force renv to save all the install packages, use `renv::snapshot(type = "simple")`

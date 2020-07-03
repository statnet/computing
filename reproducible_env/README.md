# Reproducible R environments

## Overview

As we work with different research projects, we often need different versions 
of our R packages. 

Using the [`renv` package from RStudio](https://rstudio.github.io/renv/) we can
easily record the current state of our projects as well as record the specific
versions of packages required to make it work.

## Example workflow

### Personal computer

Let's start with a new project on our personal computer:

1. Create the project with RStudio
2. run `renv::init()` in the R console (from the project)
3. reload the project
4. Work as usual

Once renv is initialize, we find ourselves in a project were no packages
installed. We can install what we need using `install.packages()` and 
`remotes::install_github()` as usual. The packages are installed in the 
project's library, allowing multiple projects to use a different version of the 
same package (e.g. EpiModelHIV).

The `renv::snapshot()` command record the state of the packages in the project 
into a "renv.lock" file. This file contains the information on every packages 
and their versions. This will permit to rebuild the environment of the project 
easily on another computer.

## Moving to hyak

Let's consider now that our project has grown and needs to run simulations on 
hyak. 

I assume your project is now living in a private GitHub repository, with the 
"renv.lock" file up to date and in the repository.

### Preparation

Before we can continue we need to add the following lines to our "~/.bashrc" 
file: 

```
export RENV_PATHS_ROOT="/gscratch/csde/renv/"

export GITHUB_PAT="\<your github private access token\>"
```

In the first line, replace <user> by your user name. This tells `renv` to store 
the files for the packages on the "csde" partition and not on the home folder. 
The latter can cause problems as the size of the home folder is limited on hyak.
  
> ### Note if /gscratch/csde/renv/" does not yet exist
>
> In this case renv will create it automatically on first use. However, for the other 
> users to use it, the following command should be run by the folder's owner
>
> `chmod -R g+rwx /gscratch/csde/renv/`
>
> Currently on hyak, Sam Jenness is the owner of the folder and the permissions
> are already correct.


The second line should contain your Github Private Access Token. This will 
allow `renv` to download packages from private GitHub repositories. This can be 
ignored if you stored it in your ".Renviron".

### Bootsraping a project

We may want to start a build session if we expect the package installation to 
require a lot of CPU and RAM.

1. First we move to our "gscratch" folder: `cd gscratch/csde/<user>/`. 
2. `git clone https://<your github private access token>@github.com/<your/project.git>`
3. Enter the project `cd <project>`
4. Start R (you may need to load it first)
5. In R: `renv::init()`. This will read the "renv.lock" file and install the 
correct version for each package.

### Running scripts on Hyak

Once `renv` is setup for your project you can run your sbatch scripts. In order for sbatch to 
use `renv`, you MUST run your scripts from the project root folder.

If your project structure is as follow:

```
project_root /
    - R/
        - script1.R
        - script2.R
        - script3.R
    - abc/
        - out/
        - master.sh     # script containing the sbatch calls
    - data/
    - renv/             # folder automatically created by renv
    - .Rprofile         # file automatically created by renv
    - renv.lock         
    - loadR.sh          # script to load R module from spack
 ```

You must then run `source abc/master.sh` from the "project_root" 
(the shell prompt should look like this: `[username@mox1 project_root]$`)

## Misc

`renv` offers a lot of advanced functionalities that are explained in more 
details on [the official website](https://rstudio.github.io/renv/)



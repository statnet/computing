Scripts to Build and Load R on Hyak::Mox
===========================

### Building R

`buildR.sh` and `buildR.master.sh` are used by the R software maintainer on Hyak (`sjenness`) to build the core R environment. These are not needed or used by end-users of Statnet/EpiModel. 


### Loading R

After a version of R has been built, it may be loaded with the `loadR.sh` script. This script can go in the end-users home directory: `/usr/lusers/USERID`, which is where you land when you login to Hyak. If you do so, you can load R immediately upon login to any node (login, interactive, build) simply with:

```bash
source ~/loadR.sh
```

You might even further automate the loading with an `alias` like this:

```bash
alias int='source ~/loadR.sh && R --no-save'
```

### Building the R package stack for EpiModelHIV

After you have loaded R on a build node, you can install all the necessary packages for `EpiModelHIV` by running the `EpiModel-Stack.R` script (usually in an interactive session). Update the EpiModelHIV branch name and add any other packages you might need. That's it! Now you're ready to run simulations using the `slurmLite` approach.

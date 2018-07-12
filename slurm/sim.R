
library("methods")
library("EpiModel")

simno <- as.numeric(Sys.getenv("SIMNO"))
jobno <- as.numeric(Sys.getenv("SLURM_ARRAY_TASK_ID"))
njobs <- as.numeric(Sys.getenv("NJOBS"))
fsimno <- paste(simno, jobno, sep = ".")

cat("Array number is ", jobno)
cat("\n fsimno is ", fsimno)

trans.prob <- as.numeric(Sys.getenv("TP"))
trans.prob2 <- as.numeric(Sys.getenv("TP2"))

# Network model estimation
nw <- network.initialize(n = 1000, bipartite = 500, directed = FALSE)
formation <- ~edges
target.stats <- 500
coef.diss <- dissolution_coefs(dissolution = ~offset(edges), duration = 50)
est1 <- netest(nw, formation, target.stats, coef.diss, verbose = FALSE)

# Epidemic model
param <- param.net(inf.prob = trans.prob, inf.prob.m2 = 0.15)
init <- init.net(i.num = 10, i.num.m2 = 10)
control <- control.net(type = "SI", nsteps = 1000, 
                       nsims = 16, ncores = 16, verbose.int = 0)
mod1 <- netsim(est1, param, init, control)

print(mod1)

fn <- paste0("sim.", fsimno, ".rda")
save(mod1, file = fn)

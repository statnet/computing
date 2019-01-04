
library("methods")
library("EpiModel")
library("EpiModelHPC")

pull_env_vars(num.vars = c("TP", "TP2"))

# Network model estimation
nw <- network.initialize(n = 1000, bipartite = 500, directed = FALSE)
formation <- ~edges
target.stats <- 500
coef.diss <- dissolution_coefs(dissolution = ~offset(edges), duration = 50)
est1 <- netest(nw, formation, target.stats, coef.diss, verbose = FALSE)

# Epidemic model
param <- param.net(inf.prob = TP, inf.prob.m2 = TP2)
init <- init.net(i.num = 10, i.num.m2 = 10)
control <- control.net(type = "SI", nsteps = 25,
                       nsims = ncores, ncores = ncores, verbose.int = 0)
mod1 <- netsim(est1, param, init, control)

print(mod1)

fn <- paste0("sim.", fsimno, ".rda")
save(mod1, file = fn)

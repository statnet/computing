
library("methods")
library("Rmpi")
library("snow")
# library("EasyABC")
library("EasyABCMPI")

uni <- mpi.universe.size()-1
print(uni)
cluster <- makeCluster(uni)
# print(cluster)

# # Print the hostname for each cluster member
# sayhello <- function() {
#   info <- Sys.info()[c("nodename", "machine")]
#   paste("Hello from", info[1], "with CPU type", info[2])
# }
#
# names <- clusterCall(cluster, sayhello)
# print(unlist(names))
#
# # # Compute row sums in parallel using all processes, then a grand sum
# # # at the end on the master process
# parallelSum <- function(m, n) {
#   A <- matrix(rnorm(m*n), nrow = m, ncol = n)
#   # Parallelize the summation
#   row.sums <- parApply(cluster, A, 1, sum)
#   print(sum(row.sums))
# }
#
# # Run the operation over different size matricies
# system.time(parallelSum(10000, 10000))

# model <- function(x) {
#   a <- runif(1e8)*x
#   return(mean(a))
# }
# run_model <- function(x, cluster) {
#   d <- parallel::parLapplyLB(cluster, x, model)
#   d <- do.call("c", d)
#   return(d)
# }
# d <- run_model(x = 1:100, cluster = cluster)
# print(d)
#
# d2 <- run_model(x = 1000:1050, cluster = cluster)
# print(d2)
#

toy_model_parallel <- function(x){
  set.seed(x[1])
  2 * x[2] + 5 + rnorm(1,0,0.1) }
sum_stat_obs <- 6.5
toy_prior <- list(c("unif",0,1))

fit <- ABC_sequential(method = "Lenormand",
                      model = toy_model_parallel,
                      prior = toy_prior,
                      nb_simul = 1000,
                      summary_stat_target = sum_stat_obs,
                      p_acc_min = 0.1,
                      use_seed = TRUE,
                      n_cluster = 95,
                      cl = cluster)

stopCluster(cluster)

mpi.exit()

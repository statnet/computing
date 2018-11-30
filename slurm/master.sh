
# Run batch queue
sbatch -p csde -A csde runsim.sh

# Run checkpoint queue (previously called backfill)
sbatch -p ckpt -A csde-ckpt runsim.sh

# Pass in environmental variables
sbatch -p csde -A csde --export=ALL,TP=0.4,TP2=0.3 runsim.sh

# Array job
sbatch -p csde -A csde --array=1-2 --export=ALL,SIMNO=1000,NJOBS=2,TP=0.4,TP2=0.3 runsim.sh

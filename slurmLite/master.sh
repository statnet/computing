#!/bin/bash

sbatch -p csde -A csde --array=1-2 --nodes=1 --ntasks-per-node=16 --time=1:00:00 --mem=58G --job-name=s1000 --export=ALL,SIMNO=1000,TP=0.1,TP2=0.2 runsim.sh
sbatch -p csde -A csde --array=1-2 --nodes=1 --ntasks-per-node=16 --time=1:00:00 --mem=58G --job-name=s1001 --export=ALL,SIMNO=1001,TP=0.2,TP2=0.2 runsim.sh
sbatch -p csde -A csde --array=1-2 --nodes=1 --ntasks-per-node=16 --time=1:00:00 --mem=58G --job-name=s1002 --export=ALL,SIMNO=1002,TP=0.1,TP2=0.4 runsim.sh
sbatch -p csde -A csde --array=1-2 --nodes=1 --ntasks-per-node=16 --time=1:00:00 --mem=58G --job-name=s1003 --export=ALL,SIMNO=1003,TP=0.2,TP2=0.4 runsim.sh

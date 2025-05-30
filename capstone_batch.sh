#!/bin/bash
#SBATCH --partition=batch
#SBATCH --job-name=capstone
#SBATCH --ntasks=1
#SBATCH --time=4:00:00
#SBATCH --mem=2gb
#SBATCH --mail-user=mgp46969@uga.edu
#SBATCH --mail-type=ALL

cd /work/binf8960/mgp46969/capstone

#Run capstone script
bash capstone.sh

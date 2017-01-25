#!/bin/sh

# compile code
vcs -sverilog -l comp.log -timescale=1ns/1ps -full64 $1 $2 $3;
# check if compile passed by checking exit code of previous command
if [ "$?" = "0" ]; then
    # run simulation
    ./simv +ntb_random_seed=10 +vcs+lic+wait $4
else
    echo "Compile Failed"
fi

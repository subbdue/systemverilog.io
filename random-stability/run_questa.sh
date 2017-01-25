#!/bin/sh

# compile code
vlog $1 $2 $3
# check if compile passed by checking exit code of previous command
if [ "$?" = "0" ]; then
    # run simulation
    vsim -c test -sv_seed 10 $4 -do "run -all"
else
    echo "Compile Failed"
fi


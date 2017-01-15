#!/bin/sh

# compile code
vlog $1 $2
# check if compile passed by checking exit code of previous command
if [ "$?" = "0" ]; then
    # run simulation
    vsim -c test -sv_seed 10 $3 -do "run -all"
else
    echo "Compile Failed"
fi


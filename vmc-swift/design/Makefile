seed = 1

default: test

test: compile run

run:
	./simv -l simv.log +ntb_random_seed=$(seed)

compile:
	vcs -l vcs.log -full64 -sverilog -f flist.f +vcs+vcdpluson

dve:
	dve -vpd vcdplus.vpd &

clean:
	rm -rf simv* csrc* *.tmp *.vpd *.key *.log *hdrs.h *.fsdb verdiLog novas.* *.dat

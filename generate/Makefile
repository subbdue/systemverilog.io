run:
	vcs -l compile.log -sverilog -full64 tb_crc_gen.sv crc_gen.sv
	./simv -l run.log

waves:
	vcs -l compile.log -sverilog -full64 -debug_pp +define+SNPS tb_crc_gen.sv crc_gen.sv
	./simv -l run.log

clean:
	rm -rf simv.daidir simv *.log csrc ucli.key vcdplus.vpd 


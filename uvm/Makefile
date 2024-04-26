####
####/*
#### * Copyright (c) 2018, Marcelo Samsoniuk
#### * All rights reserved.
#### * 
#### * Redistribution and use in source and binary forms, with or without
#### * modification, are permitted provided that the following conditions are met:
#### * 
#### * * Redistributions of source code must retain the above copyright notice, this
#### *   list of conditions and the following disclaimer.
#### * 
#### * * Redistributions in binary form must reproduce the above copyright notice,
#### *   this list of conditions and the following disclaimer in the documentation
#### *   and/or other materials provided with the distribution.
#### * 
#### * * Neither the name of the copyright holder nor the names of its
#### *   contributors may be used to endorse or promote products derived from
#### *   this software without specific prior written permission.
#### * 
#### * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
#### * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
#### * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
#### * DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
#### * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
#### * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
#### * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
#### * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
#### * OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
#### * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE. 
#### */

# Makefile variables
VERILOG_SOURCES = darksimv.v
VERILOG_SOURCES += ../rtl/darksocv.v
VERILOG_SOURCES += ../rtl/darkriscv.v
VERILOG_SOURCES += ../rtl/darkpll.v
VERILOG_SOURCES += ../rtl/darkuart.v
VERILOG_SOURCES += ../rtl/config.vh
VERILOG_SOURCES += darksocv_top.sv
FILES = $(VERILOG_SOURCES)

UVM_HOME=/home/uvm/uvm-1.1d
VCS_FLAGS = -sverilog -ntb_opts uvm-1.1 +plusarg_save -timescale=1ns/1ns -debug_access+all
UVM_FLAGS = +incdir+$(UVM_HOME)/src $(UVM_HOME)/src/uvm.sv

all:clean vcs verdi
# Targets
vcs: $(FILES)
	@if [ ! -e $(UVM_HOME)/src/uvm.sv ]; then \
		echo "*******************************************************"; \
		echo "Environment variable UVM_HOME is not set or points to incorrect path"; \
		echo "*******************************************************"; \
		exit 1; \
	fi
	vcs +v2k $(VCS_FLAGS) $(FILES) -full64 -sverilog  -timescale=1ns/1ps -l comp.log -debug_all -debug_pp \
		   -o simv		   
	./simv -l sim.log +notimingcheck +nospecify -k ucli.key

verdi: vcs
	@if [ ! -e $(UVM_HOME)/src/uvm_pkg.sv ]; then \
		echo "*******************************************************"; \
		echo "Environment variable UVM_HOME is not set or points to incorrect path"; \
		echo "*******************************************************"; \
		exit 1; \
	fi
	verdi -sv $(UVM_FLAGS) $(FILES) -ssf top.fsdb &

tops: simv_dbg
	simv_dbg -l simv_dbg.log -gui

simv_dbg: $(FILES)
	vcs $(VCS_FLAGS) $(FILES) -l comp_dbg.log -debug_all -debug_pp -o simv_dbg -Mdir=csrc_dbg -ssf *.fsdb

DIR = $(shell basename `pwd`)

tar: clean
	cd ..; \
	tar cvf $(DIR).tar $(DIR)

clean:
	@rm -rf simv* csrc* *.log *.key core* .__solver* *.vp *.vcd
	@rm -rf *~ .__snps* *.bck .vcsmx_rebuild vc_hdrs.h DVEfiles
	@rm -rf work vsim.wlf INCA_libs transcript simv.shm

.PHONY: vcs verdi tops simv_dbg tar clean

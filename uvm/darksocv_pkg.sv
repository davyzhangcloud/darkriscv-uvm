/*
 * Copyright (c) 2024, Davy Zhang
 * All rights reserved.
 * 
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 * 
 * * Redistributions of source code must retain the above copyright notice, this
 *   list of conditions and the following disclaimer.
 * 
 * * Redistributions in binary form must reproduce the above copyright notice,
 *   this list of conditions and the following disclaimer in the documentation
 *   and/or other materials provided with the distribution.
 * 
 * * Neither the name of the copyright holder nor the names of its
 *   contributors may be used to endorse or promote products derived from
 *   this software without specific prior written permission.
 * 
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
 * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
 * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
 * OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE. 
 */

package darksocv_pkg;
    `include "uvm_macros.svh"
    import uvm_pkg::*;

    class darksocv_transaction extends uvm_sequence_item;
        // 定义 transaction 属性
        rand logic [31:0] data;
        rand logic [7:0] addr;
        // 其他属性

        `uvm_object_utils(darksocv_transaction)

        function new(string name = "darksocv_transaction");
            super.new(name);
        endfunction
    endclass

    class darksocv_monitor extends uvm_monitor;
        `uvm_component_utils(darksocv_monitor)
        virtual darksocv_if vif;

        function new(string name, uvm_component parent);
            super.new(name, parent);
        endfunction

        virtual task run_phase(uvm_phase phase);
            // 监控 DUT 信号，采样并产生 transaction
        endtask
    endclass

    class darksocv_driver extends uvm_driver #(darksocv_transaction);
        `uvm_component_utils(darksocv_driver)

        virtual darksocv_if vif;

        function new(string name, uvm_component parent);
            super.new(name, parent);
        endfunction

        virtual task run_phase(uvm_phase phase);
            // 从 sequencer 获取 transaction，驱动 DUT 输入
        endtask
    endclass

    class darksocv_sequencer extends uvm_sequencer #(darksocv_transaction);
        `uvm_component_utils(darksocv_sequencer)

        function new(string name, uvm_component parent);
            super.new(name, parent);
        endfunction
    endclass

    class darksocv_agent extends uvm_agent;
        `uvm_component_utils(darksocv_agent)

        darksocv_monitor monitor;
        darksocv_driver driver;
        darksocv_sequencer sequencer;
        virtual darksocv_if vif;

        function new(string name, uvm_component parent);
            super.new(name, parent);
            monitor = darksocv_monitor::type_id::create("monitor", this);
            driver = darksocv_driver::type_id::create("driver", this);
            sequencer = darksocv_sequencer::type_id::create("sequencer", this);
        endfunction

        virtual function void build_phase(uvm_phase phase);
            super.build_phase(phase);
            monitor.vif = vif;
            driver.vif = vif;
        endfunction

        virtual function void connect_phase(uvm_phase phase);
            driver.seq_item_port.connect(sequencer.seq_item_export);
        endfunction
    endclass

    class darksocv_scoreboard extends uvm_scoreboard;
        `uvm_component_utils(darksocv_scoreboard)

        function new(string name, uvm_component parent);
            super.new(name, parent);
        endfunction

        virtual task run_phase(uvm_phase phase);
            // 比较实际输出与预期输出
        endtask
    endclass
endpackage

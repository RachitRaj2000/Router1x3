package test_pkg;

  typedef enum{UVM_PASSIVE, UVM_ACTIVE} uvm_active_passive_enum;
  import uvm_pkg::*;
  `include "uvm_macros.svh"
  `include "src_xtn.sv"
  `include "dest_xtn.sv"
  `include "src_config.sv"
  `include "dest_config.sv"
  `include "env_config.sv"
  `include "src_sequencer.sv"
  `include "dest_sequencer.sv"
  `include "src_monitor.sv"
  `include "dest_monitor.sv"
  `include "src_driver.sv"
  `include "dest_driver.sv"
  `include "src_agent.sv"
  `include "dest_agent.sv"
  `include "src_agt_top.sv"
  `include "dest_agt_top.sv"
  `include "virtual_sequencer.sv"
  `include "scoreboard.sv"
  `include "env.sv"
  `include "src_seqs.sv"
  `include "dest_seqs.sv"
  `include "virtual_seqs.sv"
  `include "test.sv"
endpackage

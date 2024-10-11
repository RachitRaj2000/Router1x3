/************************************************************************
  
Copyright 2019 - Maven Silicon Softech Pvt Ltd.  
  
www.maven-silicon.com 
  
All Rights Reserved. 
This source code is an unpublished work belongs to Maven Silicon Softech Pvt Ltd. 
It is not to be shared with or used by any third parties who have not enrolled for our paid 
training courses or received any written authorization from Maven Silicon.
  
Filename:       ram_test_pkg.sv
  
Author Name:    Putta Satish

Support e-mail: For any queries, reach out to us on "techsupport_vm@maven-silicon.com" 

Version:	1.0

*/
package test_pkg;

  typedef enum{UVM_PASSIVE, UVM_ACTIVE} uvm_active_passive_enum;

  // Importing UVM package
  import uvm_pkg::*;
  
  // Including macros and other necessary files
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

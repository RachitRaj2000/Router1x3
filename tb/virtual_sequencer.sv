/************************************************************************
  
Copyright 2019 - Maven Silicon Softech Pvt Ltd.  
  
www.maven-silicon.com 
  
All Rights Reserved. 
This source code is an unpublished work belongs to Maven Silicon Softech Pvt Ltd. 
It is not to be shared with or used by any third parties who have not enrolled for our paid 
training courses or received any written authorization from Maven Silicon.
  
Filename:       ram_virtual_sequencer.sv
  
Author Name:    Putta Satish

Support e-mail: For any queries, reach out to us on "techsupport_vm@maven-silicon.com" 

Version:	1.0

************************************************************************/
//------------------------------------------
// CLASS DESCRIPTION
//------------------------------------------


   
   // Extend ram_virtual_sequencer from uvm_sequencer
	class virtual_sequencer extends uvm_sequencer #(uvm_sequence_item) ;
   
   // Factory Registration
	`uvm_component_utils(virtual_sequencer)

   // LAB : Declare dynamic array of handles for ram_wr_sequencer and ram_rd_sequencer as wr_seqrh[] & rd_seqrh[]

	src_sequencer src_seqrh[];
	dest_sequencer dest_seqrh[];
//	ram_rd_sequencer rd_seqrh[];

   // LAB : Declare handle for ram_env_config 
  	env_config env_cfg;


//------------------------------------------
// METHODS
//------------------------------------------

// Standard UVM Methods:
 	extern function new(string name = "virtual_sequencer",uvm_component parent=null);
	extern function void build_phase(uvm_phase phase);
	endclass

   // Define Constructor new() function
	function virtual_sequencer::new(string name="virtual_sequencer",uvm_component parent=null);
		super.new(name,parent);
	endfunction

   // function void build_phase(uvm_phase phase)
	function void virtual_sequencer::build_phase(uvm_phase phase);
		// get the config object ram_env_config using uvm_config_db 
	  if(!uvm_config_db #(env_config)::get(this,"","env_config",env_cfg))
		`uvm_fatal("CONFIG","cannot get() env_cfg from uvm_config_db. Have you set() it?")
    		 super.build_phase(phase);
		// LAB : Create dynamic array handles wr_seqrh & rd_seqrh equal to
		// the config parameter no_of_duts
    		src_seqrh=new[env_cfg.no_of_source_agents];
		dest_seqrh=new[env_cfg.no_of_dest_agents];
	endfunction

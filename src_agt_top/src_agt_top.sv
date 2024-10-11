/************************************************************************
  
Copyright 2019 - Maven Silicon Softech Pvt Ltd.  
  
www.maven-silicon.com 
  
All Rights Reserved. 
This source code is an unpublished work belongs to Maven Silicon Softech Pvt Ltd. 
It is not to be shared with or used by any third parties who have not enrolled for our paid 
training courses or received any written authorization from Maven Silicon.
  
Filename:       ram_wr_agt_top.sv
  
Author Name:    Putta Satish

Support e-mail: For any queries, reach out to us on "techsupport_vm@maven-silicon.com" 

Version:	1.0

************************************************************************/
//------------------------------------------
// CLASS DESCRIPTION
//------------------------------------------

   // Extend ram_wr_agt_top from uvm_env;
	class src_agt_top extends uvm_env;

   // Factory Registration
	`uvm_component_utils(src_agt_top)
    	env_config env_cfg;
   // Create the agent handle
      	 src_agent agnth[];
//------------------------------------------
// METHODS
//------------------------------------------

// Standard UVM Methods:
	extern function new(string name = "src_agt_top" , uvm_component parent=null);
	extern function void build_phase(uvm_phase phase);
//	extern task run_phase(uvm_phase phase);
  endclass
//-----------------  constructor new method  -------------------//
   // Define Constructor new() function
   	function src_agt_top::new(string name = "src_agt_top" , uvm_component parent=null);
		super.new(name,parent);
	endfunction

    
//-----------------  build() phase method  -------------------//
       	function void src_agt_top::build_phase(uvm_phase phase);
		uvm_config_db #(env_config)::get(this,"","env_config",env_cfg);
		agnth=new[env_cfg.no_of_source_agents];
		foreach(agnth[i]) begin
// Create the instance of ram_wr_agent
		uvm_config_db #(src_config)::set(this,$sformatf("agnth[%0d]*",i),"src_config",env_cfg.src_cfg[i]);
   		agnth[i]=src_agent::type_id::create($sformatf("agnth[%0d]",i),this);
		end
	
     		super.build_phase(phase);
	endfunction


//-----------------  run_phase method  -------------------//
       // Print the topology
//	task ram_wr_agt_top::run_phase(uvm_phase phase);
//		uvm_top.print_topology;
//	endtask   



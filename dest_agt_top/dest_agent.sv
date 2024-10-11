/************************************************************************
  
Copyright 2019 - Maven Silicon Softech Pvt Ltd.  
  
www.maven-silicon.com 
  
All Rights Reserved. 
This source code is an unpublished work belongs to Maven Silicon Softech Pvt Ltd. 
It is not to be shared with or used by any third parties who have not enrolled for our paid 
training courses or received any written authorization from Maven Silicon.
  
Filename:       ram_wr_agent.sv
  
Author Name:    Putta Satish

Support e-mail: For any queries, reach out to us on "techsupport_vm@maven-silicon.com" 

Version:	1.0

************************************************************************/

//------------------------------------------
// CLASS DESCRIPTION
//------------------------------------------

   // Extend ram_wr_agent from uvm_agent
	class dest_agent extends uvm_agent;

   // Factory Registration
	`uvm_component_utils(dest_agent)

   // Declare handle for configuration object
        dest_config dest_cfg;
   // Declare handles of ram_wr_monitor,ram_wr_sequencer and ram_wr_driver
   // with Handle names as monh, seqrh, drvh respectively
	dest_monitor monh;
	dest_sequencer seqrh;
	dest_driver drvh;

//------------------------------------------
// METHODS
//------------------------------------------

// Standard UVM Methods:
  extern function new(string name = "dest_agent", uvm_component parent = null);
  extern function void build_phase(uvm_phase phase);
  extern function void connect_phase(uvm_phase phase);

endclass : dest_agent
//-----------------  constructor new method  -------------------//

       function dest_agent::new(string name = "dest_agent",uvm_component parent = null);
         super.new(name, parent);
       endfunction
     
  
//-----------------  build() phase method  -------------------//
         // Call parent build_phase
         // Create ram_wr_monitor instance
         // If is_active=UVM_ACTIVE, create ram_wr_driver and ram_wr_sequencer instances
	function void dest_agent::build_phase(uvm_phase phase);
                // get the config object using uvm_config_db 
	  if(!uvm_config_db #(dest_config)::get(this,"","dest_config",dest_cfg)) begin
		`uvm_fatal("CONFIG","cannot get() m_cfg from uvm_config_db. Have you set() it?")
		end 
	        monh=dest_monitor::type_id::create("monh",this);	
		if(dest_cfg.is_active==UVM_ACTIVE)
		begin
		drvh=dest_driver::type_id::create("drvh",this);
		seqrh=dest_sequencer::type_id::create("seqrh",this);
		end
		super.build_phase(phase);
	endfunction

      
//-----------------  connect() phase method  -------------------//
	//If is_active=UVM_ACTIVE, 
        //connect driver(TLM seq_item_port) and sequencer(TLM seq_item_export)
      
	function void dest_agent::connect_phase(uvm_phase phase);
		if(dest_cfg.is_active==UVM_ACTIVE)
		begin
		drvh.seq_item_port.connect(seqrh.seq_item_export);
  		end
	endfunction

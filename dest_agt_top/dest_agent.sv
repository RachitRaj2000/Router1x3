class dest_agent extends uvm_agent;
`uvm_component_utils(dest_agent)
dest_config dest_cfg;
dest_monitor monh;
dest_sequencer seqrh;
dest_driver drvh;

extern function new(string name = "dest_agent", uvm_component parent = null);
extern function void build_phase(uvm_phase phase);
extern function void connect_phase(uvm_phase phase);

endclass : dest_agent

function dest_agent::new(string name = "dest_agent",uvm_component parent = null);
super.new(name, parent);
endfunction
     
function void dest_agent::build_phase(uvm_phase phase);
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
function void dest_agent::connect_phase(uvm_phase phase);
		if(dest_cfg.is_active==UVM_ACTIVE)
		begin
		drvh.seq_item_port.connect(seqrh.seq_item_export);
  		end
endfunction

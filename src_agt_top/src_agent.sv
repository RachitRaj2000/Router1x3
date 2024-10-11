class src_agent extends uvm_agent;
`uvm_component_utils(src_agent)
src_config src_cfg;
src_monitor monh;
src_sequencer seqrh;
src_driver drvh;
extern function new(string name = "src_agent", uvm_component parent = null);
extern function void build_phase(uvm_phase phase);
extern function void connect_phase(uvm_phase phase);

endclass : src_agent

function src_agent::new(string name = "src_agent", 
                               uvm_component parent = null);
         super.new(name, parent);
endfunction
function void src_agent::build_phase(uvm_phase phase);
		super.build_phase(phase);
	  if(!uvm_config_db #(src_config)::get(this,"","src_config",src_cfg)) begin
		`uvm_fatal("CONFIG","cannot get() m_cfg from uvm_config_db. Have you set() it?")
		end 
	        monh=src_monitor::type_id::create("monh",this);	
		if(src_cfg.is_active==UVM_ACTIVE)
		begin
		drvh=src_driver::type_id::create("drvh",this);
		seqrh=src_sequencer::type_id::create("seqrh",this);
		end
endfunction
function void src_agent::connect_phase(uvm_phase phase);
		if(src_cfg.is_active==UVM_ACTIVE)
		begin
		drvh.seq_item_port.connect(seqrh.seq_item_export);
  		end
endfunction
   

   



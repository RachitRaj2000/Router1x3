class virtual_sequencer extends uvm_sequencer #(uvm_sequence_item) ;
	`uvm_component_utils(virtual_sequencer)
	src_sequencer src_seqrh[];
	dest_sequencer dest_seqrh[];
  	env_config env_cfg;
 	extern function new(string name = "virtual_sequencer",uvm_component parent=null);
	extern function void build_phase(uvm_phase phase);
endclass
	function virtual_sequencer::new(string name="virtual_sequencer",uvm_component parent=null);
		super.new(name,parent);
	endfunction
	function void virtual_sequencer::build_phase(uvm_phase phase);
	  if(!uvm_config_db #(env_config)::get(this,"","env_config",env_cfg))
		`uvm_fatal("CONFIG","cannot get() env_cfg from uvm_config_db. Have you set() it?")
    		 super.build_phase(phase);
    		src_seqrh=new[env_cfg.no_of_source_agents];
		dest_seqrh=new[env_cfg.no_of_dest_agents];
	endfunction

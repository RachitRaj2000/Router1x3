class env_config extends uvm_object;
int has_scoreboard =1;
int no_of_source_agents = 1;
int  no_of_dest_agents = 3;
int  has_virtual_sequencer = 1;
src_config src_cfg[];
dest_config dest_cfg[];
`uvm_object_utils(env_config)
extern function new(string name = "env_config");
endclass: env_config
function env_config::new(string name = "env_config");
  super.new(name);
endfunction



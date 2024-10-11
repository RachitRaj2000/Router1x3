	class dest_agt_top extends uvm_env;

	`uvm_component_utils(dest_agt_top)
    	env_config env_cfg;
      	 dest_agent agnth[];
	extern function new(string name = "dest_agt_top" , uvm_component parent=null);
	extern function void build_phase(uvm_phase phase);
  endclass
   	function dest_agt_top::new(string name = "dest_agt_top" , uvm_component parent=null);
		super.new(name,parent);
	endfunction

    	function void dest_agt_top::build_phase(uvm_phase phase);
		uvm_config_db #(env_config)::get(this,"","env_config",env_cfg);
		agnth=new[env_cfg.no_of_dest_agents];
		foreach(agnth[i]) begin
		uvm_config_db #(dest_config)::set(this,$sformatf("agnth[%0d]*",i),"dest_config",env_cfg.dest_cfg[i]);
   		agnth[i]=dest_agent::type_id::create($sformatf("agnth[%0d]",i),this);
		end
		super.build_phase(phase);
	endfunction

class src_agt_top extends uvm_env;

	`uvm_component_utils(src_agt_top)
    	env_config env_cfg;
      	 src_agent agnth[];
	extern function new(string name = "src_agt_top" , uvm_component parent=null);
	extern function void build_phase(uvm_phase phase);
  endclass
   	function src_agt_top::new(string name = "src_agt_top" , uvm_component parent=null);
		super.new(name,parent);
	endfunction
       	function void src_agt_top::build_phase(uvm_phase phase);
		uvm_config_db #(env_config)::get(this,"","env_config",env_cfg);
		agnth=new[env_cfg.no_of_source_agents];
		foreach(agnth[i]) begin
		uvm_config_db #(src_config)::set(this,$sformatf("agnth[%0d]*",i),"src_config",env_cfg.src_cfg[i]);
   		agnth[i]=src_agent::type_id::create($sformatf("agnth[%0d]",i),this);
		end
	
     		super.build_phase(phase);
	endfunction

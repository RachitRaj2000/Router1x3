class env extends uvm_env;
     	`uvm_component_utils(env)
	src_agt_top src_agtop;
	dest_agt_top dest_agtop;
	virtual_sequencer v_sequencer;
	scoreboard sb;
        env_config env_cfg;
extern function new(string name = "env", uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern function void connect_phase(uvm_phase phase);

endclass: env
	
	function env::new(string name = "env", uvm_component parent);
		super.new(name,parent);
	endfunction


      	function void env::build_phase(uvm_phase phase);
	  if(!uvm_config_db #(env_config)::get(this,"","env_config",env_cfg))
		`uvm_fatal("CONFIG","cannot get() m_cfg from uvm_config_db. Have you set() it?")
	          src_agtop=src_agt_top::type_id::create("src_agtop",this);
	 	  dest_agtop=dest_agt_top::type_id::create("dest_agtop",this);

               if(env_cfg.has_virtual_sequencer)
	         v_sequencer=virtual_sequencer::type_id::create("v_sequencer",this);
               if (env_cfg.has_scoreboard)
		sb=scoreboard::type_id::create("sb",this);
		super.build_phase(phase);
		endfunction

   		function void env::connect_phase(uvm_phase phase);
                      if(env_cfg.has_virtual_sequencer) begin
				for(int i=0;i<env_cfg.no_of_source_agents;i++)
				v_sequencer.src_seqrh[i] = src_agtop.agnth[i].seqrh;
				for(int i=0;i<env_cfg.no_of_dest_agents;i++)
				v_sequencer.dest_seqrh[i]=dest_agtop.agnth[i].seqrh;
                        end

   		     if(env_cfg.has_scoreboard) begin
					for(int i=0;i<env_cfg.no_of_source_agents;i++)
						src_agtop.agnth[i].monh.monitor_port.connect(sb.fifo_src_h[i].analysis_export);
					for(int i=0;i<env_cfg.no_of_dest_agents;i++)
						dest_agtop.agnth[i].monh.ap.connect(sb.fifo_dest_h[i].analysis_export);
					
					end
	endfunction

class base_test extends uvm_test;
    
    `uvm_component_utils(base_test)

  
    env envh;
    
    env_config env_cfg;
    src_config src_cfg[];
    dest_config dest_cfg[];

    int has_scoreboard=1;
    int has_virtual_sequencer=1;
    int no_of_source_agents = 1;
    int no_of_dest_agents= 3;
	extern function new(string name = "base_test" , uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern function void config_router();
	extern function void end_of_elaboration_phase(uvm_phase phase);
endclass
function base_test::new(string name = "base_test" , uvm_component parent);
	super.new(name,parent);
endfunction

function void base_test::config_router();
			src_cfg = new[no_of_source_agents];
			dest_cfg = new[no_of_dest_agents];
	
	        foreach(src_cfg[i]) 
				begin

					src_cfg[i]=src_config::type_id::create($sformatf("src_cfg[%0d]", i));
					if(!uvm_config_db #(virtual src_if)::get(this,"", $sformatf("vif_%0d",i),src_cfg[i].vif))
					`uvm_fatal("VIF CONFIG","cannot get()interface vif from uvm_config_db. Have you set() it?") 
					src_cfg[i].is_active = UVM_ACTIVE;
					env_cfg.src_cfg[i] = src_cfg[i];
                		end
		foreach(dest_cfg[i])
				begin
					dest_cfg[i]=dest_config::type_id::create($sformatf("dest_cfg[%0d]",i));
					if(!uvm_config_db #(virtual dest_if)::get(this,"",$sformatf("dest_vif_%0d",i),dest_cfg[i].vif))
						`uvm_fatal("VIF_CONFIG","cannot get() interface vif from uvm_config_db. Have you set it?")
					dest_cfg[i].is_active=UVM_ACTIVE;
					env_cfg.dest_cfg[i]=dest_cfg[i];
				end
    env_cfg.no_of_source_agents = no_of_source_agents;
    env_cfg.no_of_dest_agents=no_of_dest_agents;
    env_cfg.has_virtual_sequencer=has_virtual_sequencer;
    env_cfg.has_scoreboard=has_scoreboard;
		
endfunction : config_router



function void base_test::build_phase(uvm_phase phase);
	env_cfg=env_config::type_id::create("env_cfg");
        env_cfg.src_cfg = new[no_of_source_agents];
        env_cfg.dest_cfg = new[no_of_dest_agents];
    config_router(); 
	uvm_config_db #(env_config)::set(this,"*","env_config",env_cfg);
    super.build_phase(phase);
	envh=env::type_id::create("envh", this);
endfunction

	
function void base_test::end_of_elaboration_phase(uvm_phase phase);
	uvm_top.print_topology();
endfunction

class small_test extends base_test;

	`uvm_component_utils(small_test)

    small_vseq small_seqh;
	bit [1:0]addr;
 	extern function new(string name ="small_test" , uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern function void end_of_elaboration_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
endclass

function small_test::new(string name = "small_test" , uvm_component parent);
	super.new(name,parent);
endfunction


            
function void small_test::build_phase(uvm_phase phase);
    super.build_phase(phase);

endfunction

function void small_test::end_of_elaboration_phase(uvm_phase phase);
	super.end_of_elaboration_phase(phase);
endfunction

task small_test::run_phase(uvm_phase phase);
	addr={$random}%3;
		`uvm_info(get_type_name(),$sformatf("ok its %0d",addr),UVM_LOW)
	uvm_config_db #(bit[1:0])::set(this,"*","bit[1:0]",addr);
	    phase.raise_objection(this);
    small_seqh=small_vseq::type_id::create("small_seqh");
    small_seqh.start(envh.v_sequencer);
	#100;
    phase.drop_objection(this);
endtask   


class medium_test extends base_test;
	bit[1:0]addr;
  
	`uvm_component_utils(medium_test)

    medium_vseq medium_seqh;
 	extern function new(string name = "medium_test" , uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern function void end_of_elaboration_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
endclass


function medium_test::new(string name = "medium_test" , uvm_component parent);
	super.new(name,parent);
endfunction


            
function void medium_test::build_phase(uvm_phase phase);
    super.build_phase(phase);
endfunction


function void medium_test::end_of_elaboration_phase(uvm_phase phase);
	super.end_of_elaboration_phase(phase);
endfunction

task medium_test::run_phase(uvm_phase phase);
	`uvm_info("Medium Test","Run phase of medium test!!.",UVM_LOW)
    addr={$random}%3;
		`uvm_info(get_type_name(),$sformatf("ok its %0d",addr),UVM_LOW)
    uvm_config_db #(bit[1:0])::set(this,"*","bit[1:0]",addr);
    phase.raise_objection(this);
    medium_seqh=medium_vseq::type_id::create("medium_seqh");
    medium_seqh.start(envh.v_sequencer);
	#100;
    phase.drop_objection(this);
endtask   


class large_test extends base_test;
	bit[1:0]addr;
  
	`uvm_component_utils(large_test)

    large_vseq large_seqh;
 	extern function new(string name = "large_test" , uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern function void end_of_elaboration_phase(uvm_phase phase); 
	extern task run_phase(uvm_phase phase);
endclass

function large_test::new(string name = "large_test" , uvm_component parent);
	super.new(name,parent);
endfunction


function void large_test::build_phase(uvm_phase phase);
    super.build_phase(phase);
endfunction

function void large_test::end_of_elaboration_phase(uvm_phase phase);
	super.end_of_elaboration_phase(phase);
endfunction


task large_test::run_phase(uvm_phase phase);
		addr={$random}%3;
		`uvm_info(get_type_name(),$sformatf("ok its %0d",addr),UVM_LOW)
    uvm_config_db #(bit[1:0])::set(this,"*","bit[1:0]",addr);
    phase.raise_objection(this);
    large_seqh=large_vseq::type_id::create("large_seqh");
    large_seqh.start(envh.v_sequencer);
	#100;
    phase.drop_objection(this);
endtask 
class addr_error_test extends base_test;
	`uvm_component_utils(addr_error_test)
	bit[1:0]addr;  
	int seed;
//	seed = $urandom_range(0,1);
//	$srandom(seed);	
	error_with_addr_vseq ewa_seq;
	function new(string name="addr_error_test",uvm_component parent);
	super.new(name,parent);
	endfunction
	function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	endfunction
	function void end_of_elaboration_phase(uvm_phase phase);
	super.end_of_elaboration_phase(phase);
	endfunction
	task run_phase(uvm_phase phase);

		addr=2'b00;
		`uvm_info(get_type_name(),$sformatf("ok its %0d",addr),UVM_LOW)	
		uvm_config_db #(bit[1:0])::set(this,"*","bit[1:0]",addr);
		phase.raise_objection(this);
		ewa_seq=error_with_addr_vseq::type_id::create("ewa_seq");
		ewa_seq.start(envh.v_sequencer);
		#100;
		phase.drop_objection(this);
	endtask
endclass
class addr_test extends base_test;
	`uvm_component_utils(addr_test)
	bit[1:0]addr;  
//	seed = $urandom_range(0,1);
//	$srandom(seed);	
	addr_vseq addr_vseq1;
	function new(string name="addr_test",uvm_component parent);
	super.new(name,parent);
	endfunction
	function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	endfunction
	function void end_of_elaboration_phase(uvm_phase phase);
	super.end_of_elaboration_phase(phase);
	endfunction
	task run_phase(uvm_phase phase);
		addr=2'b01;
		`uvm_info(get_type_name(),$sformatf("ok its %0d",addr),UVM_LOW)
		uvm_config_db #(bit[1:0])::set(this,"*","bit[1:0]",addr);
		phase.raise_objection(this);
		`uvm_info("raise obejction","going to start the v_seq from addr_test",UVM_LOW)
		addr_vseq1=addr_vseq::type_id::create("addr_vseq1");
		addr_vseq1.start(envh.v_sequencer);
		`uvm_info("drop,objection","going to end the seq",UVM_LOW)
		#100;
		phase.drop_objection(this);
	endtask
endclass
class soft_test extends base_test;

	`uvm_component_utils(soft_test)

    soft_reset_vseq soft_rst;
	bit [1:0]addr;
 	extern function new(string name ="soft_test" , uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern function void end_of_elaboration_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
endclass

function soft_test::new(string name = "soft_test" , uvm_component parent);
	super.new(name,parent);
endfunction


            
function void soft_test::build_phase(uvm_phase phase);
    super.build_phase(phase);

endfunction

function void soft_test::end_of_elaboration_phase(uvm_phase phase);
	super.end_of_elaboration_phase(phase);
endfunction

task soft_test::run_phase(uvm_phase phase);
	addr={$random}%3;
		`uvm_info(get_type_name(),$sformatf("ok its %0d",addr),UVM_LOW)
	uvm_config_db #(bit[1:0])::set(this,"*","bit[1:0]",addr);
	    phase.raise_objection(this);
    soft_rst=soft_reset_vseq::type_id::create("soft_rst");
    soft_rst.start(envh.v_sequencer);
	#100;
    phase.drop_objection(this);
endtask


class src_base_seq extends uvm_sequence #(src_xtn);  
	`uvm_object_utils(src_base_seq)
        extern function new(string name ="src_base_seq");
endclass
	function src_base_seq::new(string name ="src_base_seq");
		super.new(name);
	endfunction
	class small_sequence extends src_base_seq;
  	`uvm_object_utils(small_sequence)
	bit[1:0]addr;
        extern function new(string name ="small_sequence");
        extern task body();
	endclass
	function small_sequence::new(string name = "small_sequence");
		super.new(name);
	endfunction
	task small_sequence::body();
		uvm_config_db #(bit[1:0])::get(null,get_full_name(),"bit[1:0]",addr);
    	repeat(1)
	  begin
   	   req=src_xtn::type_id::create("req");
	   start_item(req);
   	   assert(req.randomize() with {header[1:0]==addr;header[7:2] inside {[1:20]};});
	   finish_item(req); 
	   end
    	endtask
class medium_sequence extends src_base_seq;
  	`uvm_object_utils(medium_sequence)
	bit[1:0]addr;
        extern function new(string name ="medium_sequence");
        extern task body();
endclass
	function medium_sequence::new(string name = "medium_sequence");
		super.new(name);
	endfunction
       	task medium_sequence::body(); 
	`uvm_info(get_type_name(),"This is the medium sequence class of medium packet",UVM_LOW)
	uvm_config_db #(bit[1:0])::get(null,get_full_name(),"bit[1:0]",addr);
   	repeat(1) begin
	req=src_xtn::type_id::create("req");
	start_item(req);
	assert(req.randomize() with {header[1:0]==addr;header[7:2] inside {[21:40]};});
	//`uvm_info("MEDIUM_SEQUENCE",$sformatf("printing from sequence \n %s", req.sprint()),UVM_HIGH) 
	finish_item(req);
	end
       endtask
class large_sequence extends src_base_seq;
  	`uvm_object_utils(large_sequence)
	bit[1:0]addr;
        extern function new(string name ="large_sequence");
        extern task body();
endclass
	function large_sequence::new(string name = "large_sequence");
		super.new(name);
	endfunction

       	task large_sequence::body();
	uvm_config_db #(bit[1:0])::get(null,get_full_name(),"bit[1:0]",addr);
   	repeat(1) begin
	req=src_xtn::type_id::create("req");
	start_item(req);
	assert(req.randomize() with {header[1:0]==addr;header[7:2] inside {[41:63]};});
	finish_item(req);
	end
       endtask
class error_parity_seq extends src_base_seq;
	`uvm_object_utils(error_parity_seq)
	bit [1:0]addr;
	function new(string name="error_parity_seq");
	super.new(name);
	endfunction
	task body();
		if(!uvm_config_db #(bit[1:0])::get(null,get_full_name(),"bit[1:0]",addr))
			`uvm_info(get_type_name(),"addr value not got from test!!",UVM_LOW)
		repeat(1)begin
		req=src_xtn::type_id::create("req");
		req.enb_manual_parity=1;
		start_item(req);
		assert(req.randomize() with {header[1:0]==addr;header[7:2] inside {[1:20]};});
		finish_item(req);
		end
	endtask
endclass
class addr_seq extends src_base_seq;
	`uvm_object_utils(addr_seq)
	bit [1:0]addr;
	function new(string name="addr_seq");
	super.new(name);
	endfunction
	task body();
		if(!uvm_config_db #(bit[1:0])::get(null,get_full_name(),"bit[1:0]",addr))
			`uvm_info(get_type_name(),"addr value not got from test!!",UVM_LOW)
		repeat(1) begin
		req=src_xtn::type_id::create("req");
		req.enb_manual_parity=1;
		start_item(req);
		assert(req.randomize() with {header[1:0]==addr;header[7:2] inside {[1:20]};});
		finish_item(req);
		end
	endtask
endclass

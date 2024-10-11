class dest_base_seq extends uvm_sequence #(dest_xtn);  
`uvm_object_utils(dest_base_seq)  
extern function new(string name ="dest_base_seq");
endclass
function dest_base_seq::new(string name ="dest_base_seq");
	super.new(name);
endfunction
class valid_sequence extends dest_base_seq;
  	`uvm_object_utils(valid_sequence)
        extern function new(string name ="valid_sequence");
        extern task body();
endclass
function valid_sequence::new(string name = "valid_sequence");
	super.new(name);
endfunction
task valid_sequence::body();
    repeat(1)
	begin
   	   req=dest_xtn::type_id::create("req");
	   start_item(req);
   	   assert(req.randomize() with {no_of_delays inside {[1:29]};});
	   finish_item(req); 
	end
    endtask
class soft_reset_sequence extends dest_base_seq;
  	`uvm_object_utils(soft_reset_sequence)
        extern function new(string name ="soft_reset_sequence");
        extern task body();
endclass
function soft_reset_sequence::new(string name = "soft_reset_sequence");
	super.new(name);
endfunction 
task soft_reset_sequence::body(); 
   	repeat(1) begin
	req=dest_xtn::type_id::create("req");
	start_item(req);
	assert(req.randomize() with {no_of_delays >29;});
	finish_item(req);
	end
endtask

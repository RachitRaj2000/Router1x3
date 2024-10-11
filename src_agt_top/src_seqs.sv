/************************************************************************
  
Copyright 2019 - Maven Silicon Softech Pvt Ltd.  
  
www.maven-silicon.com 
  
All Rights Reserved. 
This source code is an unpublished work belongs to Maven Silicon Softech Pvt Ltd. 
It is not to be shared with or used by any third parties who have not enrolled for our paid 
training courses or received any written authorization from Maven Silicon.
  
Filename:       ram_wr_seqs.sv
  
Author Name:    Putta Satish

Support e-mail: For any queries, reach out to us on "techsupport_vm@maven-silicon.com" 

Version:	1.0

************************************************************************/

//------------------------------------------
// CLASS DESCRIPTION
//------------------------------------------

 
  // Extend ram_wbase_seq from uvm_sequence parameterized by write_xtn 
	class src_base_seq extends uvm_sequence #(src_xtn);  
	
  // Factory registration using `uvm_object_utils

	`uvm_object_utils(src_base_seq)  
//------------------------------------------
// METHODS
//------------------------------------------

// Standard UVM Methods:
        extern function new(string name ="src_base_seq");
	endclass
//-----------------  constructor new method  -------------------//
	function src_base_seq::new(string name ="src_base_seq");
		super.new(name);
	endfunction

//------------------------------------------------------------------------------
//
// SEQUENCE: Ram Single address Write Transactions   
//
//------------------------------------------------------------------------------


//------------------------------------------
// CLASS DESCRIPTION
//------------------------------------------


  // Extend ram_single_addr_wr_xtns from ram_wbase_seq;
	class small_sequence extends src_base_seq;

  	
  // Factory registration using `uvm_object_utils
  	`uvm_object_utils(small_sequence)
	bit[1:0]addr;

//------------------------------------------
// METHODS
//------------------------------i------------

// Standard UVM Methods:
        extern function new(string name ="small_sequence");
        extern task body();
	endclass
//-----------------  constructor new method  -------------------//
	function small_sequence::new(string name = "small_sequence");
		super.new(name);
	endfunction

	  
//-----------------  task body method  -------------------//
      // Generate 10 sequence items with address always equal to 55
      // Hint use create req, start item, assert for randomization with in line
      //  constraint (with) finish item inside repeat's begin end block 
	
	task small_sequence::body();
		uvm_config_db #(bit[1:0])::get(null,get_full_name(),"bit[1:0]",addr);
    	repeat(1)
	  begin
   	   req=src_xtn::type_id::create("req");
	   start_item(req);
   	   assert(req.randomize() with {header[1:0]==addr;header[7:2] inside {[1:20]};});
	//   `uvm_info("SRC_SEQUENCE",$sformatf("printing from sequence \n %s", req.sprint()),UVM_LOW) 
	   finish_item(req); 
	   end
    	endtask


//------------------------------------------------------------------------------
//
// SEQUENCE: Ram ten Write Transactions  
//
//------------------------------------------------------------------------------


//------------------------------------------
// CLASS DESCRIPTION
//------------------------------------------


  // Extend ram_ten_wr_xtns from ram_wbase_seq;
	class medium_sequence extends src_base_seq;

  	
  // Factory registration using `uvm_object_utils
  	`uvm_object_utils(medium_sequence)
	bit[1:0]addr;
//------------------------------------------
// METHODS
//------------------------------------------

// Standard UVM Methods:
        extern function new(string name ="medium_sequence");
        extern task body();
	endclass
//-----------------  constructor new method  -------------------//
	function medium_sequence::new(string name = "medium_sequence");
		super.new(name);
	endfunction

	  
//-----------------  task body method  -------------------//
      	// Write the random data on memory address locations consecutively from 0 to 9
       // Hint use create req, start item, assert for randomization with in line
      //  constraint (with) finish item inside repeat's begin end block    
	
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


//------------------------------------------------------------------------------
//
// SEQUENCE: Ram odd Write Transactions  
//
//------------------------------------------------------------------------------


//------------------------------------------
// CLASS DESCRIPTION
//------------------------------------------


  // Extend ram_odd_wr_xtns from ram_wbase_seq;
	class large_sequence extends src_base_seq;

  	
  // Factory registration using `uvm_object_utils
  	`uvm_object_utils(large_sequence)
	bit[1:0]addr;
//------------------------------------------
// METHODS
//------------------------------------------

// Standard UVM Methods:
        extern function new(string name ="large_sequence");
        extern task body();
	endclass
//-----------------  constructor new method  -------------------//
	function large_sequence::new(string name = "large_sequence");
		super.new(name);
	endfunction

	  
//-----------------  task body method  -------------------//
      // write the 10 random data in odd memory address locations 
      // Hint use create req, start item, assert for randomization with in line
      // constraint (with) finish item inside repeat's begin end block    

       	task large_sequence::body();
//	int addrseq; 
//	addrseq=0;
		
	uvm_config_db #(bit[1:0])::get(null,get_full_name(),"bit[1:0]",addr);
   	repeat(1) begin
	req=src_xtn::type_id::create("req");
	start_item(req);
	assert(req.randomize() with {header[1:0]==addr;header[7:2] inside {[41:63]};});
	//`uvm_info("LARGE_SEQUENCE",$sformatf("printing from sequence \n %s", req.sprint()),UVM_HIGH) 
	finish_item(req);
//	addrseq=addrseq + 1;
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

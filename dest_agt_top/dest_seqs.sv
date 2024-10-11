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
	class dest_base_seq extends uvm_sequence #(dest_xtn);  
	
  // Factory registration using `uvm_object_utils

	`uvm_object_utils(dest_base_seq)  
//------------------------------------------
// METHODS
//------------------------------------------

// Standard UVM Methods:
        extern function new(string name ="dest_base_seq");
	endclass
//-----------------  constructor new method  -------------------//
	function dest_base_seq::new(string name ="dest_base_seq");
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
	class valid_sequence extends dest_base_seq;

  	
  // Factory registration using `uvm_object_utils
  	`uvm_object_utils(valid_sequence)

//------------------------------------------
// METHODS
//------------------------------i------------

// Standard UVM Methods:
        extern function new(string name ="valid_sequence");
        extern task body();
	endclass
//-----------------  constructor new method  -------------------//
	function valid_sequence::new(string name = "valid_sequence");
		super.new(name);
	endfunction

	  
//-----------------  task body method  -------------------//
      // Generate 10 sequence items with address always equal to 55
      // Hint use create req, start item, assert for randomization with in line
      //  constraint (with) finish item inside repeat's begin end block 
	
	task valid_sequence::body();
    	repeat(1)
	  begin
   	   req=dest_xtn::type_id::create("req");
	   start_item(req);
   	   assert(req.randomize() with {no_of_delays inside {[1:29]};});
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
	class soft_reset_sequence extends dest_base_seq;

  	
  // Factory registration using `uvm_object_utils
  	`uvm_object_utils(soft_reset_sequence)

//------------------------------------------
// METHODS
//------------------------------------------

// Standard UVM Methods:
        extern function new(string name ="soft_reset_sequence");
        extern task body();
	endclass
//-----------------  constructor new method  -------------------//
	function soft_reset_sequence::new(string name = "soft_reset_sequence");
		super.new(name);
	endfunction

	  
//-----------------  task body method  -------------------//
      	// Write the random data on memory address locations consecutively from 0 to 9
       // Hint use create req, start item, assert for randomization with in line
      //  constraint (with) finish item inside repeat's begin end block    
	
       task soft_reset_sequence::body(); 
   	repeat(1) begin
	req=dest_xtn::type_id::create("req");
	start_item(req);
	assert(req.randomize() with {no_of_delays >29;});
	//`uvm_info("MEDIUM_SEQUENCE",$sformatf("printing from sequence \n %s", req.sprint()),UVM_HIGH) 
	finish_item(req);
	end
       endtask

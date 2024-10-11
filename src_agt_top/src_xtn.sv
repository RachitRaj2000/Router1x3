/************************************************************************
  
Copyright 2019 - Maven Silicon Softech Pvt Ltd.  
  
www.maven-silicon.com 
  
All Rights Reserved. 
This source code is an unpublished work belongs to Maven Silicon Softech Pvt Ltd. 
It is not to be shared with or used by any third parties who have not enrolled for our paid 
training courses or received any written authorization from Maven Silicon.
  
Filename:       write_xtn.sv
  
Author Name:    Putta Satish

Support e-mail: For any queries, reach out to us on "techsupport_vm@maven-silicon.com" 

Version:	1.0

************************************************************************/

//------------------------------------------
// CLASS DESCRIPTION
//------------------------------------------


  // Extend write_xtn from uvm_sequence_item
  class src_xtn extends uvm_sequence_item;
  
// UVM Factory Registration Macro
    	`uvm_object_utils(src_xtn)

//------------------------------------------
// DATA MEMBERS (Outputs non rand, inputs rand)
//------------------------------------------

 
    
  // Add the rand fields - data (`RAM_WIDTH-1:0), address(`ADDR_SIZE – 1:0),declared in tb_defs.sv
  // write (type bit) 

	rand bit[7:0]header;    
	rand bit[7:0]payload[];
	bit[7:0]parity;
	bit pkt_valid,busy;  
	bit error;
	bit resetn;
	bit enb_manual_parity=0;
  // Add the rand control knobs declared in tb_defs.sv

        // xtn_type (enumerated type addr_t)  -  for controlling the type of transaction 
        // xtn_delay (integer type) - for inserting delay between transaction
         
//------------------------------------------
// CONSTRAINTS
//------------------------------------------
 
  // Add the following constraints :
	// Data between 20 through 90
	// Address between 0 through 200
	// Distribute weights for xtn_type : BAD_XTN=2 and GOOD_XTN=30

//	constraint a{ data inside {[0:1096]};
//		      address inside {[0:200]};
//		      xtn_type dist {BAD_XTN:=2 , GOOD_XTN:=30}; 
//		    }
 constraint c1{header[1:0] inside {[0:2]};header[7:2] inside {[1:63]};payload.size()==header[7:2];}
//------------------------------------------
// METHODS
//------------------------------------------

// Standard UVM Methods:
extern function new(string name = "src_xtn");
//extern function void do_copy(uvm_object rhs);
//extern function bit do_compare(uvm_object rhs, uvm_comparer comparer);
extern function void do_print(uvm_printer printer);
extern function void post_randomize();
endclass:src_xtn

//-----------------  constructor new method  -------------------//
//Add code for new()

	function src_xtn::new(string name = "src_xtn");
		super.new(name);
	endfunction:new
	  
//-----------------  do_copy method  -------------------//
//Add code for do_copy() to copy address, data, write, xtn_type and xtn_delay
/* function void src_xtn::do_copy (uvm_object rhs);

    // handle for overriding the variable
    src_xtn rhs_;

    if(!$cast(rhs_,rhs)) begin
    `uvm_fatal("do_copy","cast of the rhs object failed")
    end
    super.do_copy(rhs);

  // Copy over data members:
  // <var_name> = rhs_.<var_name>;

    header= rhs_.header;
  foreach(payload[i])
    payload[i]= rhs_.payload[i];
    parity= rhs_.parity;
    pkt_valid= rhs_.pkt_valid;
    error= rhs_.error;
    busy=rhs_.busy;
  endfunction:do_copy
*/

//-----------------  do_compare method -------------------//
//Add code for do_compare() to compare address, data, write, xtn_type and xtn_delay
 /* function bit  write_xtn::do_compare (uvm_object rhs,uvm_comparer comparer);

 // handle for overriding the variable
    src_xtn rhs_;

    if(!$cast(rhs_,rhs)) begin
    `uvm_fatal("do_compare","cast of the rhs object failed")
    return 0;
    end

  // Compare the data members:
  // <var_name> == rhs_.<var_name>;

    return super.do_compare(rhs,comparer) && 
    header== rhs_.header;&&
  foreach(payload[i])
    payload[i]== rhs_.payload[i];&&
    parity== rhs_.parity;&&
    pkt_valid== rhs_.pkt_valid;&&
    error== rhs_.error;&&
    busy==rhs_.busy;&&

 endfunction:do_compare 
//-----------------  do_print method  -------------------//
//Use printer.print_field for integral variables
//Use printer.print_generic for enum variables
*/
   function void  src_xtn::do_print (uvm_printer printer);
    super.do_print(printer);

   
    //                   srting name   		bitstream value     size       radix for printing
    printer.print_field( "header", 		this.header, 	    8,		 UVM_DEC		);
foreach(payload[i])
    printer.print_field( $sformatf("payload[%0d]",i),this.payload[i], 	    8,		 UVM_DEC		);
    printer.print_field( "parity", 		this.parity, 	    8,		 UVM_DEC		);
    printer.print_field( "pkt_valid", 		this.pkt_valid,    1,		 UVM_DEC		);
   
    //  	         variable name		xtn_type		$bits(variable name) 	variable name.name
    printer.print_field( "error", 		this.error,			1,	UVM_DEC);
    printer.print_field( "busy",                this.busy,              1,     UVM_DEC);
    printer.print_field( "resetn",                this.resetn,              1,     UVM_DEC);
  endfunction:do_print
    

function void src_xtn::post_randomize();
   if(enb_manual_parity==1)
	parity={$random}%63;
   else begin
    parity=header^0;
	foreach(payload[i])
	begin
	parity=parity^payload[i];
	end
   end
  endfunction : post_randomize

/************************************************************************
  
Copyright 2019 - Maven Silicon Softech Pvt Ltd.  
  
www.maven-silicon.com 
  
All Rights Reserved. 
This source code is an unpublished work belongs to Maven Silicon Softech Pvt Ltd. 
It is not to be shared with or used by any third parties who have not enrolled for our paid 
training courses or received any written authorization from Maven Silicon.
  
Filename:       ram_virtual_seqs.sv
  
Author Name:    Putta Satish

Support e-mail: For any queries, reach out to us on "techsupport_vm@maven-silicon.com" 

Version:	1.0

************************************************************************/
//------------------------------------------
// CLASS DESCRIPTION
//------------------------------------------



//------------------------------------------------------------------------------
//
// SEQUENCE: Base RAM virtual sequence - base virtual sequence with objections from which 
// all virtual sequences can be derived
//
//------------------------------------------------------------------------------

  // Extend ram_vbase_seq from uvm_sequence parameterized by uvm_sequence_item;

class vbase_seq extends uvm_sequence #(uvm_sequence_item);

	
  // Factory registration
	`uvm_object_utils(vbase_seq)  
  // LAB : Declare dynamic array of handles for ram_wr_sequencer and ram_rd_sequencer as wr_seqrh[] & rd_seqrh[]
		src_sequencer src_seqrh[];
		dest_sequencer dest_seqrh[];
//		ram_rd_sequencer read_seqrh[];        
  // Declare handle for virtual sequencer
        virtual_sequencer vsqrh;
	
 
//	ram_even_rd_xtns even_rxtns;

//	ram_odd_wr_xtns odd_wxtns;
//	ram_odd_rd_xtns odd_rxtns;

//	ram_mid1_data_wr_xtns mid1_data_wxtns;
//	ram_mid2_data_wr_xtns mid2_data_wxtns;
//	ram_high_addr_wr_xtns high_wxtns;
//	ram_mid1_addr_wr_xtns mid1_wxtns;
//	ram_mid2_addr_wr_xtns mid2_wxtns;
//	ram_mid3_addr_wr_xtns mid3_wxtns;
//	ram_mid5_addr_wr_xtns mid5_wxtns;
//	ram_mid6_addr_wr_xtns mid6_wxtns;

  // LAB :  Declare handle for ram_env_config
	env_config env_cfg;


//------------------------------------------
// METHODS
//------------------------------------------

// Standard UVM Methods:
 	extern function new(string name = "vbase_seq");
	extern task body();
	endclass : vbase_seq  
//-----------------  constructor new method  -------------------//

// Add constructor 
	function vbase_seq::new(string name ="vbase_seq");
		super.new(name);
	endfunction
//-----------------  task body() method  -------------------//


task vbase_seq::body();
// get the config object ram_env_config from database using uvm_config_db 
	  uvm_config_db#(env_config)::get(null,get_full_name(),"env_config",env_cfg);
// initialize the dynamic arrays for write & read sequencers to m_cfg.no_of_duts
		dest_seqrh=new[env_cfg.no_of_dest_agents];
		src_seqrh=new[env_cfg.no_of_source_agents];
  

  assert($cast(vsqrh,m_sequencer))else begin
    `uvm_error("BODY", "Error in $cast of virtual sequencer")
  end
// Assign ram_wr_sequencer & ram_rd_sequencer handles to virtual sequencer's 
// ram_wr_sequencer & ram_rd_sequencer handles
// Hint : use foreach loop
 	foreach(src_seqrh[i])
		src_seqrh[i]=vsqrh.src_seqrh[i];
	foreach(dest_seqrh[i])
		dest_seqrh[i]=vsqrh.dest_seqrh[i];
endtask: body

   

//------------------------------------------------------------------------------
//                 single address sequence

//------------------------------------------------------------------------------
// Extend ram_single_vseq from ram_vbase_seq
	class small_vseq extends vbase_seq;

     // Define Constructor new() function
small_sequence src_small;
valid_sequence dest_valid;

	`uvm_object_utils(small_vseq)
	bit[1:0]addr;

//------------------------------------------
// METHODS
//------------------------------------------

// Standard UVM Methods:
 	extern function new(string name = "small_vseq");
	extern task body();
	endclass : small_vseq  
//-----------------  constructor new method  -------------------//

// Add constructor 
	function small_vseq::new(string name ="small_vseq");
		super.new(name);
	endfunction
//-----------------  task body() method  -------------------//

		task small_vseq::body();
                 super.body();
			if(!uvm_config_db #(bit[1:0])::get(null,get_full_name(),"bit[1:0]",addr))
				`uvm_error(get_type_name(),"Failed while getting the addr value")
			
                 // LAB : create the instances for ram_single_addr_wr_xtns & ram_single_addr_rd_xtns
                  src_small=small_sequence::type_id::create("src_small");
		  dest_valid=valid_sequence::type_id::create("dest_valid");
//		  single_rxtns=ram_single_addr_rd_xtns::type_id::create("single_rxtns");
                  //  if(env_cfg.has_wagent) begin
                  // LAB : Start the write sequence on all the write sequencers 
	       //       foreach(src_seqrh[i])
           //         end 

                        fork
                        begin
                                src_small.start(src_seqrh[0]);
                        end
                begin
            if(addr==2'b00)
            dest_valid.start(dest_seqrh[0]);

            if(addr==2'b01)
            dest_valid.start(dest_seqrh[1]);

            if(addr==2'b10)
            dest_valid.start(dest_seqrh[2]);

                        end
                        join


      		 endtask

//------------------------------------------------------------------------------
//                 ten address sequence

//------------------------------------------------------------------------------
// Extend ram_ten_vseq from uvm_sequence

//------------------------------------------------------------------------------
//                 even sequence

//------------------------------------------------------------------------------
// Extend ram_even_vseq from ram_vbase_seq
    	 class medium_vseq extends vbase_seq;
	bit[1:0]addr;
     // Factory Registration
	`uvm_object_utils(medium_vseq)

medium_sequence src_medium;
valid_sequence dest_valid;
//------------------------------------------
// METHODS
//------------------------------------------

// Standard UVM Methods:
 	extern function new(string name = "medium_vseq");
	extern task body();
	endclass : medium_vseq  
//-----------------  constructor new method  -------------------//

// Add constructor 
	function medium_vseq::new(string name ="medium_vseq");
		super.new(name);
	endfunction
//-----------------  task body() method  -------------------//



	task medium_vseq::body();
                 super.body();
		`uvm_info(get_type_name(),"This is the virtual sequence of medium sequence test!!",UVM_LOW)
		// LAB :  create the instances for ram_even_wr_xtns & ram_even_rd_xtns
			if(!uvm_config_db #(bit[1:0])::get(null,get_full_name(),"bit[1:0]",addr))
				`uvm_error(get_type_name(),"Failed while getting the addr value")
                  src_medium=medium_sequence::type_id::create("src_medium");
		  dest_valid=valid_sequence::type_id::create("dest_valid");
			fork
			begin	
				src_medium.start(src_seqrh[0]);
			end
		begin
            if(addr==2'b00)
            dest_valid.start(dest_seqrh[0]);

            if(addr==2'b01)
            dest_valid.start(dest_seqrh[1]);

            if(addr==2'b10)
            dest_valid.start(dest_seqrh[2]);

			end
			join
       endtask
 class large_vseq extends vbase_seq;
	bit[1:0]addr;
     // Define Constructor new() function
	`uvm_object_utils(large_vseq)

large_sequence src_large;
valid_sequence dest_valid;
//------------------------------------------
// METHODS
//------------------------------------------

// Standard UVM Methods:
 	extern function new(string name = "large_vseq");
	extern task body();
	endclass : large_vseq  
//-----------------  constructor new method  -------------------//

// Add constructor 
	function large_vseq::new(string name ="large_vseq");
		super.new(name);
	endfunction
//-----------------  task body() method  -------------------//

	task large_vseq::body();
                 super.body();
                  // LAB :  create the instances for ram_ten_wr_xtns & ram_ten_rd_xtns
			if(!uvm_config_db #(bit[1:0])::get(null,get_full_name(),"bit[1:0]",addr))
				`uvm_error(get_type_name(),"Failed while getting the addr value")
		    
                  src_large=large_sequence::type_id::create("src_large");
		  dest_valid=valid_sequence::type_id::create("dest_valid");
		  //ten_rxtns=ram_ten_rd_xtns::type_id::create("ten_rxtns");

       //            if(m_cfg.has_wagent) begin
		  // LAB :  Start the write sequence on all the write sequencers
	//               foreach(write_seqrh[i])

                  //  end
                        fork
                        begin
                                src_large.start(src_seqrh[0]);
                        end
                begin
            if(addr==2'b00)
            dest_valid.start(dest_seqrh[0]);

            if(addr==2'b01)
            dest_valid.start(dest_seqrh[1]);

            if(addr==2'b10)
            dest_valid.start(dest_seqrh[2]);

                        end
                        join
     		endtask
 
class error_with_addr_vseq extends vbase_seq;
	`uvm_object_utils(error_with_addr_vseq)
	error_parity_seq ep_seq;
	valid_sequence dest_valid;
	bit[1:0]addr;
	function new(string name="error_with_addr_vseq");
	super.new(name);
	endfunction
	task body();
		super.body();
			if(!uvm_config_db #(bit[1:0])::get(null,get_full_name(),"bit[1:0]",addr))
				`uvm_error(get_type_name(),"Failed while getting the addr value")
		    
                  ep_seq=error_parity_seq::type_id::create("error_parity_seq");
		  dest_valid=valid_sequence::type_id::create("dest_valid");
		  //ten_rxtns=ram_ten_rd_xtns::type_id::create("ten_rxtns");

       //            if(m_cfg.has_wagent) begin
		  // LAB :  Start the write sequence on all the write sequencers
	//               foreach(write_seqrh[i])

                  //  end
                        fork
                        begin
			`uvm_info("addr =0 seq","addr = 0 seq print",UVM_LOW)
                                ep_seq.start(src_seqrh[0]);
                        end
                begin
            if(addr==2'b00)
            dest_valid.start(dest_seqrh[0]);

            if(addr==2'b01)
            dest_valid.start(dest_seqrh[1]);

            if(addr==2'b10)
            dest_valid.start(dest_seqrh[2]);

                        end
		join
	endtask
			
endclass
class addr_vseq extends vbase_seq;
	`uvm_object_utils(addr_vseq)
	addr_seq addr_seq1;
	valid_sequence dest_valid;
	bit[1:0]addr;
	function new(string name="addr_vseq");
	super.new(name);
	endfunction
	task body();
		super.body();
			`uvm_info("after super.body()","going to get addr value from test in v seq addr_vseq",UVM_LOW)
			if(!uvm_config_db #(bit[1:0])::get(null,get_full_name(),"bit[1:0]",addr))
				`uvm_error(get_type_name(),"Failed while getting the addr value")
		    
                  addr_seq1=addr_seq::type_id::create("addr_seq1");
		  dest_valid=valid_sequence::type_id::create("dest_valid");
		  //ten_rxtns=ram_ten_rd_xtns::type_id::create("ten_rxtns");

       //            if(m_cfg.has_wagent) begin
		  // LAB :  Start the write sequence on all the write sequencers
	//               foreach(write_seqrh[i])

                  //  end
                        fork
                        begin
                                addr_seq1.start(src_seqrh[0]);
                        end
                begin
            if(addr==2'b00)
            dest_valid.start(dest_seqrh[0]);

            if(addr==2'b01)
            dest_valid.start(dest_seqrh[1]);

            if(addr==2'b10)
            dest_valid.start(dest_seqrh[2]);

                        end
		join
	endtask
endclass
class soft_reset_vseq extends vbase_seq;
`uvm_object_utils(soft_reset_vseq)
soft_reset_sequence soft_rst_seq;
small_sequence  src_small;
bit[1:0]addr;
function new(string name="soft_reset_vseq");
super.new(name);
endfunction
task body();
		super.body();
		//	`uvm_info("after super.body()","going to get addr value from test in v seq addr_vseq",UVM_LOW)
			if(!uvm_config_db #(bit[1:0])::get(null,get_full_name(),"bit[1:0]",addr))
				`uvm_error(get_type_name(),"Failed while getting the addr value")
		    
                  src_small=small_sequence::type_id::create("srm_small");
		  soft_rst_seq=soft_reset_sequence::type_id::create("soft_rst_seq");
		  //ten_rxtns=ram_ten_rd_xtns::type_id::create("ten_rxtns");

       //            if(m_cfg.has_wagent) begin
		  // LAB :  Start the write sequence on all the write sequencers
	//               foreach(write_seqrh[i])

                  //  end
                        fork
                        begin
                                src_small.start(src_seqrh[0]);
                        end
                begin
            if(addr==2'b00)
            soft_rst_seq.start(dest_seqrh[0]);

            if(addr==2'b01)
            soft_rst_seq.start(dest_seqrh[1]);

            if(addr==2'b10)
            soft_rst_seq.start(dest_seqrh[2]);

                        end
		join
	endtask
endclass

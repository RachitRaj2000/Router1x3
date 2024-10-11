class vbase_seq extends uvm_sequence #(uvm_sequence_item);
	`uvm_object_utils(vbase_seq)  
		src_sequencer src_seqrh[];
		dest_sequencer dest_seqrh[];
        virtual_sequencer vsqrh;
	env_config env_cfg;
 	extern function new(string name = "vbase_seq");
	extern task body();
	endclass : vbase_seq  
	function vbase_seq::new(string name ="vbase_seq");
		super.new(name);
	endfunction
task vbase_seq::body();
	  uvm_config_db#(env_config)::get(null,get_full_name(),"env_config",env_cfg);
		dest_seqrh=new[env_cfg.no_of_dest_agents];
		src_seqrh=new[env_cfg.no_of_source_agents];
  

  assert($cast(vsqrh,m_sequencer))else begin
    `uvm_error("BODY", "Error in $cast of virtual sequencer")
  end
 	foreach(src_seqrh[i])
		src_seqrh[i]=vsqrh.src_seqrh[i];
	foreach(dest_seqrh[i])
		dest_seqrh[i]=vsqrh.dest_seqrh[i];
endtask: body
	class small_vseq extends vbase_seq;
small_sequence src_small;
valid_sequence dest_valid;

	`uvm_object_utils(small_vseq)
	bit[1:0]addr;
 	extern function new(string name = "small_vseq");
	extern task body();
	endclass : small_vseq  
	function small_vseq::new(string name ="small_vseq");
		super.new(name);
	endfunction

		task small_vseq::body();
                 super.body();
			if(!uvm_config_db #(bit[1:0])::get(null,get_full_name(),"bit[1:0]",addr))
				`uvm_error(get_type_name(),"Failed while getting the addr value")
                  src_small=small_sequence::type_id::create("src_small");
		  dest_valid=valid_sequence::type_id::create("dest_valid");
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
    	 class medium_vseq extends vbase_seq;
	bit[1:0]addr;
	`uvm_object_utils(medium_vseq)

medium_sequence src_medium;
valid_sequence dest_valid;
 	extern function new(string name = "medium_vseq");
	extern task body();
	endclass : medium_vseq  
	function medium_vseq::new(string name ="medium_vseq");
		super.new(name);
	endfunction
	task medium_vseq::body();
                 super.body();
		`uvm_info(get_type_name(),"This is the virtual sequence of medium sequence test!!",UVM_LOW)
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
	`uvm_object_utils(large_vseq)

large_sequence src_large;
valid_sequence dest_valid;
 	extern function new(string name = "large_vseq");
	extern task body();
	endclass : large_vseq  
	function large_vseq::new(string name ="large_vseq");
		super.new(name);
	endfunction
	task large_vseq::body();
                 super.body();
			if(!uvm_config_db #(bit[1:0])::get(null,get_full_name(),"bit[1:0]",addr))
				`uvm_error(get_type_name(),"Failed while getting the addr value")
		    
                  src_large=large_sequence::type_id::create("src_large");
		  dest_valid=valid_sequence::type_id::create("dest_valid");
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
			if(!uvm_config_db #(bit[1:0])::get(null,get_full_name(),"bit[1:0]",addr))
				`uvm_error(get_type_name(),"Failed while getting the addr value")
		    
                  src_small=small_sequence::type_id::create("srm_small");
		  soft_rst_seq=soft_reset_sequence::type_id::create("soft_rst_seq");
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

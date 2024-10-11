class scoreboard extends uvm_scoreboard;
`uvm_component_utils(scoreboard)
uvm_tlm_analysis_fifo #(src_xtn) fifo_src_h[];
uvm_tlm_analysis_fifo #(dest_xtn) fifo_dest_h[];
src_xtn xtn1;
dest_xtn xtn2;
env_config env_cfg;
covergroup src;
ADDR:coverpoint xtn1.header[1:0]{
	bins addr0={0};
	bins addr1={1};
	bins addr2={2};
}
PAYLOAD:coverpoint xtn1.header[7:2]{
	bins small_pkt={[1:20]};
	bins medium_pkt={[21:40]};
	bins large_pkt={[41:63]};
} 
ERROR:coverpoint xtn1.error{
	bins correct={0};
	bins wrong={1};
}
endgroup:src
covergroup dest;
ADDR:coverpoint xtn2.header[1:0]{
	bins addr0={0};
	bins addr1={1};
	bins addr2={2};	
}
PAYLOAD: coverpoint xtn2.header[7:2]{
	bins small_pkt={[1:20]};
	bins medium_pkt={[21:40]};
	bins large_pkt={[41:63]};	
}
endgroup:dest
function new(string name="scoreboard",uvm_component parent=null);
super.new(name,parent);
src=new();
dest=new();
endfunction

function void build_phase(uvm_phase phase);
if(!uvm_config_db #(env_config)::get(this,"","env_config",env_cfg))
	`uvm_error(get_type_name(),"getting env_config object failed in scoreboard")
fifo_src_h=new[env_cfg.no_of_source_agents];
fifo_dest_h=new[env_cfg.no_of_dest_agents];
foreach(fifo_src_h[i])
	fifo_src_h[i]=new($sformatf("fifo_src_h[%0d]",i),this);
foreach(fifo_dest_h[i])
	fifo_dest_h[i]=new($sformatf("fifo_dest_h[%0d]",i),this);
super.build_phase(phase);
endfunction
task run_phase(uvm_phase phase);
forever begin
	fork
	begin
		fifo_src_h[0].get(xtn1);
		xtn1.print();
		src.sample();
	end
	begin
		fork
		begin
			fifo_dest_h[0].get(xtn2);
			`uvm_info(get_type_name(),$sformatf("Data recieved from destination0 in scoreboard %s",xtn2.sprint()),UVM_LOW)
			compare_data(xtn2);
			dest.sample();
		end
		begin
			fifo_dest_h[1].get(xtn2);
			`uvm_info(get_type_name(),$sformatf("Data recieved from destination1 in scoreboard %s",xtn2.sprint()),UVM_LOW)
			compare_data(xtn2);
			dest.sample();
		end
		begin
			fifo_dest_h[2].get(xtn2);
			`uvm_info(get_type_name(),$sformatf("Data recieved from destination2 in scoreboard %s",xtn2.sprint()),UVM_LOW)
			compare_data(xtn2);
			dest.sample();
		end
		join_any
		disable fork;
		//compare_data(xtn2);
	end
	join
end
endtask
task compare_data(dest_xtn xtn2);
if(xtn1.header==xtn2.header)
	`uvm_info(get_type_name(),"Header compared !!",UVM_LOW)
else
`uvm_error(get_type_name(),"Header matching failed!!")
if(xtn1.payload==xtn2.payload)
	`uvm_info(get_type_name(),"payload is matched!!",UVM_LOW)
else
`uvm_error(get_type_name(),"payload is mismatched")
if(xtn1.parity==xtn2.parity)
	`uvm_info(get_full_name(),"parity is matched!!",UVM_LOW)
else
	`uvm_error(get_full_name(),"Parity is mismatched!!")
endtask
endclass

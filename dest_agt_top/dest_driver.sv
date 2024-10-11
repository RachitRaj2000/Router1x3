class dest_driver extends uvm_driver#(dest_xtn);
`uvm_component_utils(dest_driver)
virtual dest_if.DRV_MP vif;
dest_config d_cfg;
function new(string name="dest_driver", uvm_component parent);
super.new(name,parent);
endfunction
function void build_phase(uvm_phase phase);
super.build_phase(phase);
if(!uvm_config_db#(dest_config)::get(this,"","dest_config",d_cfg))
`uvm_fatal(get_type_name(),"not able to get config object of destination.")
endfunction

function void connect_phase(uvm_phase phase);
super.connect_phase(phase);
vif=d_cfg.vif;
endfunction

task run_phase(uvm_phase phase);
forever
   begin
    seq_item_port.get_next_item(req);//data from seq
	send_to_dut(req);
	seq_item_port.item_done();
   end
endtask  

task send_to_dut(dest_xtn xtn);
while(vif.DRV_CB.valid_out==0)
	@(vif.DRV_CB);
repeat(xtn.no_of_delays)
@(vif.DRV_CB);
vif.DRV_CB.read_enb<=1'b1;
//xtn.dest_drv_data_xtn_cnt+=1;
while(vif.DRV_CB.valid_out)
	@(vif.DRV_CB);
	@(vif.DRV_CB);
	vif.DRV_CB.read_enb<=1'b0;

`uvm_info(get_type_name(),$sformatf("Driven data from destination side %0s",xtn.sprint()),UVM_LOW)

endtask	  
endclass

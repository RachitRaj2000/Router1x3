class src_driver extends uvm_driver #(src_xtn);
`uvm_component_utils(src_driver)
virtual src_if.DRV_MP vif;
src_config src_cfg;
	extern function new(string name ="src_driver",uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern function void connect_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
	extern task send_to_dut(src_xtn xtn);
endclass
	function src_driver::new(string name ="src_driver",uvm_component parent);
		super.new(name,parent);
	endfunction
 	function void src_driver::build_phase(uvm_phase phase);
          super.build_phase(phase);
	  if(!uvm_config_db #(src_config)::get(this,"","src_config",src_cfg))
		`uvm_fatal(get_type_name(),"cannot get() m_cfg from uvm_config_db. Have you set() it?") 
        endfunction
 	function void src_driver::connect_phase(uvm_phase phase);
          vif = src_cfg.vif;
        endfunction
	task src_driver::run_phase(uvm_phase phase);
		@(vif.DRV_CB);
		vif.DRV_CB.resetn<=1'b0;
		@(vif.DRV_CB);
		vif.DRV_CB.resetn<=1'b1;
               	forever begin
		seq_item_port.get_next_item(req);
		send_to_dut(req);
		seq_item_port.item_done();
		end
	endtask
	task src_driver::send_to_dut(src_xtn xtn);

      	    while(vif.DRV_CB.busy==1)
			@(vif.DRV_CB);
	`uvm_info(get_type_name(),"Driving starts from source side!!",UVM_LOW)
		vif.DRV_CB.pkt_valid<=1'b1;
		vif.DRV_CB.data_in<=xtn.header;
		@(vif.DRV_CB);
		foreach(xtn.payload[i])
				begin
				while(vif.DRV_CB.busy==1)
					@(vif.DRV_CB);
				vif.DRV_CB.data_in<=xtn.payload[i];
				@(vif.DRV_CB);
				end

	while(vif.DRV_CB.busy==1)
	 @(vif.DRV_CB);

		vif.DRV_CB.pkt_valid<=1'b0;
		vif.DRV_CB.data_in<=xtn.parity;

   `uvm_info("SRC_DRIVER",$sformatf("printing from driver \n %s", xtn.sprint()),UVM_LOW) 
endtask




	



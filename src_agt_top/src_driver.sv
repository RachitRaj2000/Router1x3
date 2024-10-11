/************************************************************************
  
Copyright 2019 - Maven Silicon Softech Pvt Ltd.  
  
www.maven-silicon.com 
  
All Rights Reserved. 
This source code is an unpublished work belongs to Maven Silicon Softech Pvt Ltd. 
It is not to be shared with or used by any third parties who have not enrolled for our paid 
training courses or received any written authorization from Maven Silicon.
  
Filename:       ram_wr_driver.sv
  
Author Name:    Putta Satish

Support e-mail: For any queries, reach out to us on "techsupport_vm@maven-silicon.com" 

Version:	1.0

************************************************************************/
//------------------------------------------
// CLASS DESCRIPTION
//------------------------------------------


   // Extend ram_wr_driver from uvm driver parameterized by write_xtn
	class src_driver extends uvm_driver #(src_xtn);

   // Factory Registration

	`uvm_component_utils(src_driver)

   // Declare virtual interface handle with WDR_MP as modport
   	virtual src_if.DRV_MP vif;

   // Declare the ram_wr_agent_config handle as "m_cfg"
        src_config src_cfg;



//------------------------------------------
// METHODS
//------------------------------------------

// Standard UVM Methods:
     	
	extern function new(string name ="src_driver",uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern function void connect_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
	extern task send_to_dut(src_xtn xtn);
	//extern function void report_phase(uvm_phase phase);
endclass

//-----------------  constructor new method  -------------------//
 // Define Constructor new() function
	function src_driver::new(string name ="src_driver",uvm_component parent);
		super.new(name,parent);
	endfunction

//-----------------  build() phase method  -------------------//
 	function void src_driver::build_phase(uvm_phase phase);
	// call super.build_phase(phase);
          super.build_phase(phase);
	// get the config object using uvm_config_db 
	  if(!uvm_config_db #(src_config)::get(this,"","src_config",src_cfg))
		`uvm_fatal(get_type_name(),"cannot get() m_cfg from uvm_config_db. Have you set() it?") 
        endfunction

//-----------------  connect() phase method  -------------------//
	// in connect phase assign the configuration object's virtual interface
	// to the driver's virtual interface instance(handle --> "vif")
 	function void src_driver::connect_phase(uvm_phase phase);
          vif = src_cfg.vif;
        endfunction


//-----------------  run() phase method  -------------------//
	 // In forever loop
	    // Get the sequence item using seq_item_port
            // Call send_to_dut task 
            // Get the next sequence item using seq_item_port  

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

//-----------------  task send_to_dut() method  -------------------//

   // Add task send_to_dut(write_xtn handle as an input argument)
	
	task src_driver::send_to_dut(src_xtn xtn);
		// Print the transaction
                 // Add the write logic

 //  `uvm_info("SRC_DRIVER","000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",UVM_LOW) 

      	    while(vif.DRV_CB.busy==1)
			@(vif.DRV_CB);

 //`uvm_info("SRC_DRIVER","01010101010101010101010101010101010101010101010101010101010101010101010101010",UVM_LOW) 
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
			

           //   repeat(5)
             // @(vif.DRV_CB);
	// increment drv_data_sent_cnt
   	//      src_cfg.drv_data_sent_cnt++;
endtask

  // UVM report_phase
//  function void src_driver::report_phase(uvm_phase phase);
  //  `uvm_info(get_type_name(), $sformatf("Report: SRC driver sent %0d transactions", src_cfg.drv_data_sent_cnt), UVM_LOW)
 // endfunction



	



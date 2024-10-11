/************************************************************************
  
Copyright 2019 - Maven Silicon Softech Pvt Ltd.  
  
www.maven-silicon.com 
  
All Rights Reserved. 
This source code is an unpublished work belongs to Maven Silicon Softech Pvt Ltd. 
It is not to be shared with or used by any third parties who have not enrolled for our paid 
training courses or received any written authorization from Maven Silicon.
  
Filename:       ram_wr_monitor.sv
  
Author Name:    Putta Satish

Support e-mail: For any queries, reach out to us on "techsupport_vm@maven-silicon.com" 

Version:	1.0

************************************************************************/
//------------------------------------------
// CLASS DESCRIPTION
//------------------------------------------

   // Extend ram_wr_monitor from uvm_monitor

class src_monitor extends uvm_monitor;

  // Factory Registration
	`uvm_component_utils(src_monitor)

  // Declare virtual interface handle with WMON_MP as modport
   	virtual src_if.MON_MP vif;

  // Declare the ram_wr_agent_config handle as "m_cfg"
        src_config src_cfg;

  // Analysis TLM port to connect the monitor to the scoreboard for lab09
  	uvm_analysis_port #(src_xtn) monitor_port;


//------------------------------------------
// METHODS
//------------------------------------------

// Standard UVM Methods:
extern function new(string name = "src_monitor", uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern function void connect_phase(uvm_phase phase);
extern task run_phase(uvm_phase phase);
extern task collect_data();
//extern function void report_phase(uvm_phase phase);

endclass 
//-----------------  constructor new method  -------------------//
	function src_monitor::new(string name = "src_monitor", uvm_component parent);
		super.new(name,parent);
		// create object for handle monitor_port using new
 		monitor_port = new("monitor_port", this);

  	endfunction

//-----------------  build() phase method  -------------------//
 	function void src_monitor::build_phase(uvm_phase phase);
	// call super.build_phase(phase);
          super.build_phase(phase);
	// get the config object using uvm_config_db 
	  if(!uvm_config_db #(src_config)::get(this,"","src_config",src_cfg))
		`uvm_fatal(get_type_name(),"cannot get() src_cfg from uvm_config_db. Have you set() it?") 
        endfunction

//-----------------  connect() phase method  -------------------//
	// in connect phase assign the configuration object's virtual interface
	// to the monitor's virtual interface instance(handle --> "vif")
 	function void src_monitor::connect_phase(uvm_phase phase);
          vif = src_cfg.vif;
        endfunction


//-----------------  run() phase method  -------------------//
	

        // In forever loop
        // Call task collect_data
       task src_monitor::run_phase(uvm_phase phase);
        forever
        // Call collect data task
       collect_data();     
       endtask


   // Collect Reference Data from DUV IF 
        task src_monitor::collect_data();
	// Declare handle to collect data as data_sent
         src_xtn xtn;
	// Create an instance data_sent
	 xtn= src_xtn::type_id::create("xtn");


	//xtn.resetn=vif.MON_CB.resetn;

  //   `uvm_info("SRC_MONITOR","11111111111111111111111111111111111111111111111111111111111111",UVM_LOW) 

	while(vif.MON_CB.busy)
//	while(vif.MON_CB.pkt_valid==0)
		@(vif.MON_CB);
	while(vif.MON_CB.pkt_valid==0)
		@(vif.MON_CB);

//     `uvm_info("SRC_MONITOR","22222222222222222222222222222222222222222222222222222222222222222222222222",UVM_LOW) 

		xtn.header=vif.MON_CB.data_in;
		xtn.payload=new[xtn.header[7:2]];

		@(vif.MON_CB);

	foreach(xtn.payload[i]) begin
			while(vif.MON_CB.busy)
				@(vif.MON_CB);
			
			xtn.payload[i]=vif.MON_CB.data_in;
			@(vif.MON_CB);
		end
	//wait(vif.MON_CB.pkt_valid==1)
	while(vif.MON_CB.busy)
		@(vif.MON_CB);
	while(vif.MON_CB.pkt_valid==1)
		@(vif.MON_CB);
	xtn.parity=vif.MON_CB.data_in;
	repeat(2)
	@(vif.MON_CB);
		xtn.error=vif.MON_CB.error;
	 `uvm_info("SRC_MONITOR",$sformatf("printing from monitor \n %s", xtn.sprint()),UVM_LOW) 
	monitor_port.write(xtn);
	//Debug Print - Set Verbosity level UVM_HIGH only to debug
  	//increment mon_rcvd_xtn_cnt
//  	  src_cfg.mon_data_xtn_cnt++;
       endtask

// UVM report_phase
//  function void src_monitor::report_phase(uvm_phase phase);
  //  `uvm_info(get_type_name(), $sformatf("Report: SRC Monitor Collected %0d Transactions", src_cfg.mon_data_xtn_cnt), UVM_LOW)
 // endfunction 

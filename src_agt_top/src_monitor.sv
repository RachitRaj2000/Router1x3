class src_monitor extends uvm_monitor;
	`uvm_component_utils(src_monitor)
   	virtual src_if.MON_MP vif;
        src_config src_cfg;
  	uvm_analysis_port #(src_xtn) monitor_port;
extern function new(string name = "src_monitor", uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern function void connect_phase(uvm_phase phase);
extern task run_phase(uvm_phase phase);
extern task collect_data();

endclass 
	function src_monitor::new(string name = "src_monitor", uvm_component parent);
		super.new(name,parent);
 		monitor_port = new("monitor_port", this);

  	endfunction

 	function void src_monitor::build_phase(uvm_phase phase);
          super.build_phase(phase);
	  if(!uvm_config_db #(src_config)::get(this,"","src_config",src_cfg))
		`uvm_fatal(get_type_name(),"cannot get() src_cfg from uvm_config_db. Have you set() it?") 
        endfunction
 	function void src_monitor::connect_phase(uvm_phase phase);
          vif = src_cfg.vif;
        endfunction
       task src_monitor::run_phase(uvm_phase phase);
        forever
       collect_data();     
       endtask
        task src_monitor::collect_data();
         src_xtn xtn;
	 xtn= src_xtn::type_id::create("xtn");

	while(vif.MON_CB.busy)
		@(vif.MON_CB);
	while(vif.MON_CB.pkt_valid==0)
		@(vif.MON_CB);
		xtn.header=vif.MON_CB.data_in;
		xtn.payload=new[xtn.header[7:2]];

		@(vif.MON_CB);

	foreach(xtn.payload[i]) begin
			while(vif.MON_CB.busy)
				@(vif.MON_CB);
			
			xtn.payload[i]=vif.MON_CB.data_in;
			@(vif.MON_CB);
		end
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
       endtask

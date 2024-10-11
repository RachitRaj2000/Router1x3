class dest_monitor extends uvm_monitor;
`uvm_component_utils(dest_monitor)
dest_config d_cfg;
virtual dest_if.MON_MP vif;
uvm_analysis_port #(dest_xtn) ap;
function new(string name="dest_monitor",uvm_component parent=null);
	super.new(name,parent);
	ap=new("ap",this);
endfunction
function void build_phase(uvm_phase phase);
	if(!uvm_config_db #(dest_config)::get(this,"","dest_config",d_cfg))
		`uvm_error(get_type_name(),"Failed to get the config object from config_db..")
endfunction
function void connect_phase(uvm_phase phase);
	vif=d_cfg.vif;
endfunction
task run_phase(uvm_phase phase);
forever begin
collect_data();
end
endtask

task collect_data();
dest_xtn xtn;
xtn=dest_xtn::type_id::create("xtn");

while(vif.MON_CB.valid_out==0)
@(vif.MON_CB);


while(vif.MON_CB.read_enb==0)
@(vif.MON_CB);

@(vif.MON_CB);
xtn.header=vif.MON_CB.data_out;
xtn.payload=new[xtn.header[7:2]];
@(vif.MON_CB);
foreach(xtn.payload[i])
	begin
while(vif.MON_CB.read_enb==0)
@(vif.MON_CB);

	xtn.payload[i]=vif.MON_CB.data_out;
	@(vif.MON_CB);
	end

while(vif.MON_CB.read_enb==0)
@(vif.MON_CB);

xtn.parity=vif.MON_CB.data_out;
`uvm_info(get_type_name(),$sformatf("Sampled data from destination side %0s",xtn.sprint()),UVM_LOW)
repeat(2)
@(vif.MON_CB);
//xtn.dest_mon_data_xtn_cnt+=1;
ap.write(xtn);
endtask
endclass

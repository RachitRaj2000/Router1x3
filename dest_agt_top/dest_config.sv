class dest_config extends uvm_object;
`uvm_object_utils(dest_config)
virtual dest_if vif;
uvm_active_passive_enum is_active = UVM_ACTIVE;
static int dest_mon_data_xtn_cnt = 0;
static int dest_drv_data_sent_cnt = 0;
extern function new(string name = "dest_config");

endclass: dest_config
function dest_config::new(string name = "dest_config");
  super.new(name);
endfunction

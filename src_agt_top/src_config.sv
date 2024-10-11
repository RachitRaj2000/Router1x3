class src_config extends uvm_object;
`uvm_object_utils(src_config)
virtual src_if vif;
uvm_active_passive_enum is_active = UVM_ACTIVE;
static int mon_data_xtn_cnt = 0;
static int drv_data_sent_cnt = 0;
extern function new(string name = "src_config");

endclass: src_config
function src_config::new(string name = "src_config");
  super.new(name);
endfunction

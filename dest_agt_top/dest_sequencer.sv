class dest_sequencer extends uvm_sequencer#(dest_xtn);
`uvm_component_utils(dest_sequencer)
function new(string name="dest_sequencer",uvm_component parent=null);
super.new(name,parent);
endfunction
endclass

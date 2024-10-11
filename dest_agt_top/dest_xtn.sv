class dest_xtn extends uvm_sequence_item;

    	`uvm_object_utils(dest_xtn)
	bit[7:0]header;    
	bit[7:0]payload[];
	bit[7:0]parity;
	bit read_enb;
	bit valid_out;
	rand bit [4:0]no_of_delays;
extern function new(string name = "dest_xtn");
extern function void do_print(uvm_printer printer);
endclass:dest_xtn
	function dest_xtn::new(string name = "dest_xtn");
		super.new(name);
	endfunction:new
   function void  dest_xtn::do_print (uvm_printer printer);
    super.do_print(printer);
    printer.print_field( "header", 		this.header, 	    8,		 UVM_DEC		);
foreach(payload[i])
    printer.print_field( $sformatf("payload[%0d]",i),this.payload[i], 	    8,		 UVM_DEC		);
    printer.print_field( "read_enb",                this.read_enb,              1,     UVM_DEC);
    printer.print_field( "valid_out",                this.valid_out,              1,     UVM_DEC);
  endfunction:do_print

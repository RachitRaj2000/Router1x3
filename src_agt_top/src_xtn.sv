class src_xtn extends uvm_sequence_item;
    	`uvm_object_utils(src_xtn)
	rand bit[7:0]header;    
	rand bit[7:0]payload[];
	bit[7:0]parity;
	bit pkt_valid,busy;  
	bit error;
	bit resetn;
	bit enb_manual_parity=0;
	constraint c1{header[1:0] inside {[0:2]};header[7:2] inside {[1:63]};payload.size()==header[7:2];}
	extern function new(string name = "src_xtn");
	extern function void do_print(uvm_printer printer);
	extern function void post_randomize();
endclass:src_xtn
function src_xtn::new(string name = "src_xtn");
	super.new(name);
endfunction:new
function void  src_xtn::do_print (uvm_printer printer);
    super.do_print(printer);
	printer.print_field( "header", 		this.header, 	    8,		 UVM_DEC		);
	foreach(payload[i])
	    printer.print_field( $sformatf("payload[%0d]",i),this.payload[i], 	    8,		 UVM_DEC		);
	    printer.print_field( "parity", 		this.parity, 	    8,		 UVM_DEC		);
	    printer.print_field( "pkt_valid", 		this.pkt_valid,    1,		 UVM_DEC		);
	    printer.print_field( "error", 		this.error,			1,	UVM_DEC);
	    printer.print_field( "busy",                this.busy,              1,     UVM_DEC);
	    printer.print_field( "resetn",                this.resetn,              1,     UVM_DEC);
endfunction:do_print
    

function void src_xtn::post_randomize();
   if(enb_manual_parity==1)
	parity={$random}%63;
   else begin
    parity=header^0;
	foreach(payload[i])
	begin
	parity=parity^payload[i];
	end
   end
  endfunction : post_randomize

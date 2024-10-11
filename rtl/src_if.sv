interface src_if(input bit  clock);

bit [7:0]data_in;
bit resetn;
bit pkt_valid;
bit error;
bit busy;
clocking DRV_CB@(posedge clock);
	default input #1 output #0;
	input busy;
	output data_in;
	output pkt_valid;
	output resetn;
endclocking

clocking MON_CB@(posedge clock);
	default input #1 output #0;
	input error;
	input resetn;
	input data_in;
	input busy;
	input pkt_valid;
endclocking

modport DRV_MP(clocking DRV_CB);
modport MON_MP(clocking MON_CB);
modport DUV_MP(input clock,input resetn,input pkt_valid,input data_in,output error,output busy);

endinterface

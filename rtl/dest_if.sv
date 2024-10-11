interface dest_if(input bit clock);

bit valid_out;
bit read_enb;
bit [7:0]data_out;


clocking DRV_CB@(posedge clock);
//default input #1 output #0;
input valid_out;
output read_enb;
endclocking


clocking MON_CB@(posedge clock);

//default input #1 output #0;
input valid_out;
input read_enb;
input data_out;
endclocking



modport DRV_MP(clocking DRV_CB);
modport MON_MP(clocking MON_CB);
endinterface:dest_if

interface interface_if(input clk, rst);
    logic [15:0] A;
    logic  [1:0] reg_sel;
    logic  [1:0] instru;
    logic        valid;
    
    modport mst(input clk, rst, busy_o, dt_o, output dt_i, enb_i);
    modport slv(input clk, rst, dt_i, enb_i, output busy_o, dt_o);
endinterface
